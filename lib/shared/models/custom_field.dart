class CustomFields {
  String? conversionrate;
  String? conversionrategroup;
  String? variationBarcode;
  String? minprice;
  String? toHide;
  String? cost;
  dynamic stockQuantityOverwrite;
  String? variationShelf;

  CustomFields({
    this.conversionrate,
    this.conversionrategroup,
    this.variationBarcode,
    this.minprice,
    this.toHide,
    this.cost,
    this.stockQuantityOverwrite,
    this.variationShelf,
  });

  factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
        conversionrate: json["conversionrate"],
        conversionrategroup: json["conversionrategroup"],
        variationBarcode: json["variation_barcode"],
        minprice: json["minprice"],
        toHide: json["to_hide"],
        cost: json["cost"],
        stockQuantityOverwrite: json["stock_quantity_overwrite"],
        variationShelf: json["variation_shelf"],
      );

  Map<String, dynamic> toJson() => {
        "conversionrate": conversionrate,
        "conversionrategroup": conversionrategroup,
        "variation_barcode": variationBarcode,
        "minprice": minprice,
        "to_hide": toHide,
        "cost": cost,
        "stock_quantity_overwrite": stockQuantityOverwrite,
        "variation_shelf": variationShelf,
      };
}