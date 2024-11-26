import 'package:get/get.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartService extends GetxService {
  var cartItems = <CartItemModel>[].obs;

  void addToCart(ProductModel product, int quantity, String uom) {
    removeFromCart(product);
    cartItems.add(CartItemModel(
        id: product.id ?? 0,
        product: product,
        quantity: quantity,
        uom: uom,
        totalPrice: calculateTotalPrice(product, quantity, uom)));
  }

  void removeFromCart(ProductModel product) {
    cartItems.removeWhere((element) => element.id == product.id);
  }

  void removeAllFromCart() {
    cartItems.clear();
  }

  double calculateTotalPrice(ProductModel product, int quantity, String uom) {
    return quantity *
        (double.tryParse(product.variations?.where((element) => element.uom == uom).first.regularPrice ?? "0") ??
            double.tryParse(product.regularPrice ?? "0") ??
            0);
  }

  int get totalItems => cartItems.length;
}
