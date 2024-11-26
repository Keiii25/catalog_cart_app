import 'package:catalog_cart_app/core/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/colors.dart';
import 'controllers/products_controller.dart';

class CatalogSearchBar extends StatelessWidget {
  const CatalogSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();

    return SizedBox(
      height: context.screenWidth * 0.1,
      child: TextField(
        onChanged: (value) {
          productController.searchProducts(value);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: grey9B9B9B),
          prefixIcon: Icon(Icons.search, color: grey9B9B9B),
          suffixIcon: Obx(() => productController.searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: grey9B9B9B),
                  onPressed: () {
                    productController.clearSearch();
                  },
                )
              : const SizedBox()),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: grey9B9B9B),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
        ),
      ),
    );
  }
}