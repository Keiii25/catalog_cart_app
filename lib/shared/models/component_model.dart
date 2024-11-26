import 'component_product.dart';

class Component {
  int? id;
  String? name;
  List<ComponentProduct>? products;
  dynamic numberOfDifferentProductsAllowed;
  int? minimumQuantity;
  int? maximumQuantity;
  dynamic differentSkuFreeQuantity;
  dynamic discountPercentage;
  int? discountOnRegularPrice;
  dynamic discountAmount;
  dynamic price;
  dynamic compositeMinimumOrder;
  dynamic minimumDifferentProductsAllowed;
  dynamic maximumDifferentProductsAllowed;
  dynamic scaleUpRatio;
  bool? optional;
  dynamic allowedVariations;

  Component({
    this.id,
    this.name,
    this.products,
    this.numberOfDifferentProductsAllowed,
    this.minimumQuantity,
    this.maximumQuantity,
    this.differentSkuFreeQuantity,
    this.discountPercentage,
    this.discountOnRegularPrice,
    this.discountAmount,
    this.price,
    this.compositeMinimumOrder,
    this.minimumDifferentProductsAllowed,
    this.maximumDifferentProductsAllowed,
    this.scaleUpRatio,
    this.optional,
    this.allowedVariations,
  });

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        id: json["id"],
        name: json["name"],
        products: json["products"] == null
            ? []
            : List<ComponentProduct>.from(json["products"]!.map((x) => ComponentProduct.fromJson(x))),
        numberOfDifferentProductsAllowed: json["number_of_different_products_allowed"],
        minimumQuantity: json["minimum_quantity"],
        maximumQuantity: json["maximum_quantity"],
        differentSkuFreeQuantity: json["different_sku_free_quantity"],
        discountPercentage: json["discount_percentage"],
        discountOnRegularPrice: json["discount_on_regular_price"],
        discountAmount: json["discount_amount"],
        price: json["price"],
        compositeMinimumOrder: json["composite_minimum_order"],
        minimumDifferentProductsAllowed: json["minimum_different_products_allowed"],
        maximumDifferentProductsAllowed: json["maximum_different_products_allowed"],
        scaleUpRatio: json["scale_up_ratio"],
        optional: json["optional"],
        allowedVariations: json["allowed_variations"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "number_of_different_products_allowed": numberOfDifferentProductsAllowed,
        "minimum_quantity": minimumQuantity,
        "maximum_quantity": maximumQuantity,
        "different_sku_free_quantity": differentSkuFreeQuantity,
        "discount_percentage": discountPercentage,
        "discount_on_regular_price": discountOnRegularPrice,
        "discount_amount": discountAmount,
        "price": price,
        "composite_minimum_order": compositeMinimumOrder,
        "minimum_different_products_allowed": minimumDifferentProductsAllowed,
        "maximum_different_products_allowed": maximumDifferentProductsAllowed,
        "scale_up_ratio": scaleUpRatio,
        "optional": optional,
        "allowed_variations": allowedVariations,
      };
}
