import 'product_model.dart';

class CartItemModel {
  final int id;
  final ProductModel product;
  int quantity;
  String uom;
  double? individualPrice;
  double? totalPrice;

  CartItemModel({required this.id, required this.product, required this.quantity, required this.uom, this.individualPrice, this.totalPrice});
}
