import 'package:get/get.dart';

import '../../../../core/controllers/base_controller.dart';
import '../../../../shared/services/cart_service.dart';
import '../../../../shared/models/product_model.dart';
import '../../../../shared/models/cart_item_model.dart';

class CartController extends BaseController {
  final CartService cartService = Get.find<CartService>();

  List<CartItemModel> get cartItems => cartService.cartItems;

  void removeFromCart(ProductModel product) {
    cartService.removeFromCart(product);
  }

  void removeAllFromCart() {
    cartService.removeAllFromCart();
  }
}
