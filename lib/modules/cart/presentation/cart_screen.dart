import 'package:catalog_cart_app/core/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../../core/text_styles.dart';
import '../../../core/utils.dart';
import '../../../shared/models/product_model.dart';
import '../../catolog/presentation/product_item.dart';
import 'controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final CartController cartController = Get.find();
    return Scaffold(
      backgroundColor: greyF5F5F5,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          l10n.cart,
          style: AppTextStyles.bodyLargeBold.copyWith(color: Colors.white),
        ),
        actions: [
          Text(
            l10n.companyName,
            style: AppTextStyles.bodyRegular.copyWith(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'CN',
                style: AppTextStyles.bodyLargeBold.copyWith(color: Colors.blue),
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (String value) {
              switch (value) {
                case 'Clear':
                  cartController.removeAllFromCart();
              }
            },
            itemBuilder: (BuildContext context) => [
               PopupMenuItem<String>(
                value: 'Clear',
                child: Center(
                    child: Text(
                  l10n.clear,
                  style: AppTextStyles.bodyRegular,
                )),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() =>
               ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  ProductModel product = cartController.cartItems[index].product;
                  return Dismissible(
                    key: Key(product.id.toString()),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      cartController.removeFromCart(product);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ProductItem(
                              product: product,
                              isCart: true,
                              index: index,
                              uom: cartController.cartItems[index].uom,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                labelBar(
                                    l10n.order,
                                    "${cartController.cartItems[index].quantity} ${cartController.cartItems[index].uom}",
                                    Colors.blue),
                                const Icon(
                                  Icons.arrow_right_outlined,
                                ),
                                labelBar(
                                    l10n.total,
                                    toRM(cartController.cartItems[index].totalPrice, rm: true, decimal: true),
                                    Colors.orange),
                              ],
                            ),
                            const Divider(),
                            index == cartController.cartItems.length - 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(l10n.total),
                                      Text(toRM(
                                          cartController.cartItems.fold(0.0, (sum, item) => sum + (item.totalPrice ?? 0)),
                                          rm: true,
                                          decimal: true))
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: grey9B9B9B))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${l10n.total} (${cartController.cartItems.length})',
                            style: AppTextStyles.bodyRegular.copyWith(color: grey9B9B9B),
                          ),
                          Text(
                              toRM(cartController.cartItems.fold(0.0, (sum, item) => sum + (item.totalPrice ?? 0)),
                                  rm: true, decimal: true),
                              style: AppTextStyles.bodyLargeBold),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child:  Text(
                        l10n.checkout,
                        style: AppTextStyles.bodyBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget labelBar(String label, String value, Color color) {
  return Row(
    children: [
      Container(
        width: 4,
        height: 32,
        color: color,
      ),
      const SizedBox(
        width: 8,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyRegular.copyWith(color: grey9B9B9B),
          ),
          Text(
            value,
            style: AppTextStyles.bodyLargeBold,
          )
        ],
      )
    ],
  );
}
