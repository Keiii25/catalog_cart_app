import 'package:catalog_cart_app/core/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/colors.dart';
import '../../../core/enums.dart';
import '../../../core/text_styles.dart';
import '../../../shared/models/product_model.dart';
import '../../../shared/models/variation_model.dart';
import 'controllers/products_controller.dart';
import 'product_item.dart';
import 'catalog_search_bar.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    final l10n = context.l10n;

    void onMinusButtonPressed(ProductModel product) {
      int newQuantity =
          (productController.unsavedCartItems.where((element) => element.id == product.id).firstOrNull?.quantity ?? 0) -
              1;
      if (newQuantity < 0) {
        productController.removeFromUnsavedCart(product);
      } else {
        productController.editProductQuantityUnsavedCart(product, newQuantity);
      }
    }

    void onAddQuantityButtonPressed(ProductModel product) {
      int newQuantity =
          (productController.unsavedCartItems.where((element) => element.id == product.id).firstOrNull?.quantity ?? 0) +
              1;
      productController.editProductQuantityUnsavedCart(product, newQuantity);
    }

    void onAddButtonPressed(ProductModel product) {
      productController.addProductToCart(product, productController.quantity(product), productController.uom(product));
    }

    List<DropdownMenuItem<String>> getUomDropdownItems(ProductModel product) {
      return product.variations?.map<DropdownMenuItem<String>>((Variation item) {
            return DropdownMenuItem<String>(
              value: item.uom,
              child: Text(item.uom ?? ""),
            );
          }).toList() ??
          [];
    }

    Widget buildUomDropdown(ProductModel product) {
      final dropdownItems = getUomDropdownItems(product);
      String currentValue = productController.uom(product);

      if (currentValue.isEmpty && dropdownItems.isNotEmpty) {
        currentValue = dropdownItems.first.value ?? "";
        productController.editProductUomUnsavedCart(product, currentValue);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: greyE1E1E1),
            top: BorderSide(color: greyE1E1E1),
            bottom: BorderSide(color: greyE1E1E1),
          ),
        ),
        child: DropdownButton<String>(
          value: currentValue,
          items: dropdownItems,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                productController.editProductUomUnsavedCart(product, value);
              }
            });
          },
        ),
      );
    }

    Widget unitChangedButton(ProductModel product) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: greyE1E1E1)),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => onMinusButtonPressed(product),
            ),
            const SizedBox(
              width: 8,
            ),
            Obx(() => Text(productController.quantity(product).toString())),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onAddQuantityButtonPressed(product),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Expanded(
              flex: 6,
              child: Text(
                l10n.categoriesName,
                style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              flex: 5,
              child: Text(
                l10n.companyName,
                style: AppTextStyles.bodyRegular.copyWith(color: Colors.white),
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'CN',
                  style: AppTextStyles.bodyBold.copyWith(color: Colors.blue),
                ),
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (String value) {},
            itemBuilder: (BuildContext context) => [],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(flex: 22, child: CatalogSearchBar()),
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: IconButton(
                    icon: Stack(
                      children: [
                        const Icon(Icons.shopping_cart),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                            child: Obx(
                              () => Text(productController.cartItems.length.toString(),
                                  style: const TextStyle(fontSize: 12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoute.cart.path);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: productController.scrollController,
                  itemCount: productController.products.length +
                      (productController.hasMore.value && productController.searchQuery.isEmpty ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < productController.products.length) {
                      ProductModel product = productController.products[index];
                      return Column(
                        children: [
                          ProductItem(
                            product: product,
                            uom: productController.uom(product),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildUomDropdown(product),
                                unitChangedButton(product),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Colors.blue,
                                    size: 36,
                                  ),
                                  onPressed: () => onAddButtonPressed(product),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
