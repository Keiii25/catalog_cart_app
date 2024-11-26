import '../../core/enums.dart';
import 'bulk_variation_input_model.dart';
import 'category_model.dart';
import 'dimension_model.dart';
import 'product_attribute_model.dart';
import 'variation_model.dart';

class ComponentProduct {
  int? id;
  String? name;
  DateTime? dateModified;
  ProductType? type;
  Status? status;
  String? catalogVisibility;
  String? sku;
  String? regularPrice;
  dynamic salePrice;
  String? taxClass;
  bool? manageStock;
  bool? inStock;
  int? stockQuantity;
  dynamic weight;
  Dimensions? dimensions;
  bool? backordersAllowed;
  dynamic description;
  List<Category>? categories;
  List<dynamic>? tags;
  List<dynamic>? images;
  List<ProductAttribute>? attributes;
  List<dynamic>? defaultAttributes;
  BulkVariationInput? bulkVariationInput;
  int? menuOrder;
  List<Variation>? variations;
  Map<String, String?>? customFields;
  List<dynamic>? customFieldsV2;
  List<int>? allowedVariations;

  ComponentProduct({
    this.id,
    this.name,
    this.dateModified,
    this.type,
    this.status,
    this.catalogVisibility,
    this.sku,
    this.regularPrice,
    this.salePrice,
    this.taxClass,
    this.manageStock,
    this.inStock,
    this.stockQuantity,
    this.weight,
    this.dimensions,
    this.backordersAllowed,
    this.description,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.bulkVariationInput,
    this.menuOrder,
    this.variations,
    this.customFields,
    this.customFieldsV2,
    this.allowedVariations,
  });

  factory ComponentProduct.fromJson(Map<String, dynamic> json) => ComponentProduct(
        id: json["id"],
        name: json["name"],
        dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
        type: productTypeValues.map[json["type"]]!,
        status: statusValues.map[json["status"]]!,
        catalogVisibility: json["catalog_visibility"],
        sku: json["sku"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        inStock: json["in_stock"],
        stockQuantity: json["stock_quantity"],
        weight: json["weight"],
        dimensions: json["dimensions"] == null ? null : Dimensions.fromJson(json["dimensions"]),
        backordersAllowed: json["backorders_allowed"],
        description: json["description"],
        categories:
            json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
        images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
        attributes: json["attributes"] == null
            ? []
            : List<ProductAttribute>.from(json["attributes"]!.map((x) => ProductAttribute.fromJson(x))),
        defaultAttributes:
            json["default_attributes"] == null ? [] : List<dynamic>.from(json["default_attributes"]!.map((x) => x)),
        bulkVariationInput:
            json["bulk_variation_input"] == null ? null : BulkVariationInput.fromJson(json["bulk_variation_input"]),
        menuOrder: json["menu_order"],
        variations: json["variations"] == null
            ? []
            : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
        customFields: Map.from(json["custom_fields"]!).map((k, v) => MapEntry<String, String?>(k, v)),
        customFieldsV2:
            json["custom_fields_v2"] == null ? [] : List<dynamic>.from(json["custom_fields_v2"]!.map((x) => x)),
        allowedVariations:
            json["allowed_variations"] == null ? [] : List<int>.from(json["allowed_variations"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_modified": dateModified?.toIso8601String(),
        "type": productTypeValues.reverse[type],
        "status": statusValues.reverse[status],
        "catalog_visibility": catalogVisibility,
        "sku": sku,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "in_stock": inStock,
        "stock_quantity": stockQuantity,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "backorders_allowed": backordersAllowed,
        "description": description,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "default_attributes": defaultAttributes == null ? [] : List<dynamic>.from(defaultAttributes!.map((x) => x)),
        "bulk_variation_input": bulkVariationInput?.toJson(),
        "menu_order": menuOrder,
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toJson())),
        "custom_fields": Map.from(customFields!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "custom_fields_v2": customFieldsV2 == null ? [] : List<dynamic>.from(customFieldsV2!.map((x) => x)),
        "allowed_variations": allowedVariations == null ? [] : List<dynamic>.from(allowedVariations!.map((x) => x)),
      };
}
