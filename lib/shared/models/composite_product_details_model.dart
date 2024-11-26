import 'component_model.dart';

class CompositeProductDetails {
  bool? perItemPricing;
  List<Component>? components;

  CompositeProductDetails({
    this.perItemPricing,
    this.components,
  });

  factory CompositeProductDetails.fromJson(Map<String, dynamic> json) => CompositeProductDetails(
        perItemPricing: json["per_item_pricing"],
        components: json["components"] == null
            ? []
            : List<Component>.from(json["components"]!.map((x) => Component.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "per_item_pricing": perItemPricing,
        "components": components == null ? [] : List<dynamic>.from(components!.map((x) => x.toJson())),
      };
}