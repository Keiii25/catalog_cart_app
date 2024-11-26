import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/controllers/base_controller.dart';
import '../../../../core/drivers/database_helper.dart';
import '../../../../shared/services/cart_service.dart';
import '../../../../shared/models/cart_item_model.dart';
import '../../../../shared/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

class ProductController extends BaseController {
  final GetProductsUseCase getProductsUseCase;

  final RxList<ProductModel> _products = <ProductModel>[].obs;
  RxString errorMessage = ''.obs;
  RxBool hasMore = true.obs;

  int currentPage = 1;

  final ScrollController scrollController = ScrollController();
  final SembastDatabaseHelper _dbHelper = SembastDatabaseHelper();
  final CartService cartService = Get.find<CartService>();

  List<CartItemModel> get cartItems => cartService.cartItems;

  final RxList<CartItemModel> unsavedCartItems = <CartItemModel>[].obs;

  final RxString _searchQuery = ''.obs;
  final RxList<ProductModel> _filteredProducts = <ProductModel>[].obs;

  String get searchQuery => _searchQuery.value;
  List<ProductModel> get filteredProducts => _filteredProducts;

  ProductController({required this.getProductsUseCase});

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    scrollController.addListener(_scrollListener);
  }

  void fetchProducts() async {
    if (isLoading.value || !hasMore.value) return;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.first == ConnectivityResult.none) {
      loadLocalProducts();
    } else {
      try {
        isLoading(true);
        final result = await getProductsUseCase.execute(
          page: currentPage,
        );
        if (result.isEmpty) {
          hasMore(false);
        } else {
          _products.addAll(result);
          _products.refresh();
          currentPage++;
          for (ProductModel product in result) {
            await _dbHelper.insertProduct(product);
          }
        }
      } catch (e) {
        errorMessage(e.toString());
        loadLocalProducts();
      } finally {
        isLoading(false);
      }
    }
  }

  void loadLocalProducts() async {
    try {
      final localProducts = await _dbHelper.getAllProducts();
      _products.value = localProducts;
      _products.refresh();
    } catch (e) {
      print(e);
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        hasMore.value &&
        !isLoading.value) {
      fetchProducts();
    }
  }

  void addProductToCart(ProductModel product, int quantity, String uom) {
    cartService.addToCart(product, quantity, uom);
    unsavedCartItems.refresh();
  }

  void addProductToUnsavedCart(ProductModel product, int quantity, String uom) {
    unsavedCartItems.add(CartItemModel(id: product.id ?? 0, product: product, quantity: quantity, uom: uom));
    unsavedCartItems.refresh();
  }

  void removeFromUnsavedCart(ProductModel product) {
    unsavedCartItems.removeWhere((element) => element.id == product.id);
    unsavedCartItems.refresh();
  }

  void editProductQuantityUnsavedCart(ProductModel product, int quantity) {
    CartItemModel? cartItem = unsavedCartItems.where((element) => element.id == product.id).firstOrNull;
    if (cartItem != null) {
      unsavedCartItems.where((element) => element.id == product.id).firstOrNull?.quantity = quantity;
    } else {
      addProductToUnsavedCart(product, quantity, cartItem?.uom ?? product.variations?.first.uom ?? "Unit");
    }
    unsavedCartItems.refresh();
  }

  void editProductUomUnsavedCart(ProductModel product, String uom) {
    CartItemModel? cartItem = unsavedCartItems.where((element) => element.id == product.id).firstOrNull;
    if (cartItem != null) {
      unsavedCartItems.where((element) => element.id == product.id).firstOrNull?.uom = uom;
    } else {
      addProductToUnsavedCart(product, 0, uom);
    }
    unsavedCartItems.refresh();
  }

  int quantity(ProductModel product) =>
      unsavedCartItems.where((element) => element.id == product.id).firstOrNull?.quantity ?? 0;

  String uom(ProductModel product) =>
      unsavedCartItems.where((element) => element.id == product.id).firstOrNull?.uom ?? "";

  List<ProductModel> get products {
    if (_searchQuery.value.isEmpty) {
      return _products;
    }
    return _filteredProducts;
  }

  void searchProducts(String query) {
    _searchQuery.value = query;
    if (query.isEmpty) {
      _filteredProducts.clear();
      return;
    }

    _filteredProducts.value = _products.where((product) {
      final nameLower = product.name?.toLowerCase() ?? '';
      final skuLower = product.sku?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) || skuLower.contains(searchLower);
    }).toList();
  }

  void clearSearch() {
    _searchQuery.value = '';
    _filteredProducts.clear();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
