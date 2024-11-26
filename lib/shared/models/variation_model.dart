import '../../core/enums.dart';
import 'bulk_variation_input_model.dart';
import 'custom_field.dart';
import 'dimension_model.dart';
import 'inventory_model.dart';
import 'variation_attribute.dart';

class Variation {
  int? id;
  DateTime? dateModified;
  VariationType? type;
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
  List<dynamic>? categories;
  List<dynamic>? tags;
  List<Inventory>? inventory;
  List<VariationAttribute>? attributes;
  List<dynamic>? defaultAttributes;
  BulkVariationInput? bulkVariationInput;
  int? menuOrder;
  List<dynamic>? variations;
  CustomFields? customFields;
  List<dynamic>? billOfMaterials;
  int? shippingClassId;
  String? productSku;
  String? uom;
  List<dynamic>? image;

  Variation({
    this.id,
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
    this.inventory,
    this.attributes,
    this.defaultAttributes,
    this.bulkVariationInput,
    this.menuOrder,
    this.variations,
    this.customFields,
    this.billOfMaterials,
    this.shippingClassId,
    this.productSku,
    this.uom,
    this.image,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["id"],
        dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
        type: variationTypeValues.map[json["type"]],
        status: statusValues.map[json["status"]],
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
        categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
        tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
        inventory:
            json["inventory"] == null ? [] : List<Inventory>.from(json["inventory"]!.map((x) => Inventory.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<VariationAttribute>.from(json["attributes"]!.map((x) => VariationAttribute.fromJson(x))),
        defaultAttributes:
            json["default_attributes"] == null ? [] : List<dynamic>.from(json["default_attributes"]!.map((x) => x)),
        bulkVariationInput:
            json["bulk_variation_input"] == null ? null : BulkVariationInput.fromJson(json["bulk_variation_input"]),
        menuOrder: json["menu_order"],
        variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
        customFields: json["custom_fields"] == null ? null : CustomFields.fromJson(json["custom_fields"]),
        billOfMaterials:
            json["bill_of_materials"] == null ? [] : List<dynamic>.from(json["bill_of_materials"]!.map((x) => x)),
        shippingClassId: json["shipping_class_id"],
        productSku: json["product_sku"],
        uom: json["uom"],
        image: json["image"] == null ? [] : List<dynamic>.from(json["image"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_modified": dateModified?.toIso8601String(),
        "type": variationTypeValues.reverse[type],
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
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "inventory": inventory == null ? [] : List<dynamic>.from(inventory!.map((x) => x.toJson())),
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "default_attributes": defaultAttributes == null ? [] : List<dynamic>.from(defaultAttributes!.map((x) => x)),
        "bulk_variation_input": bulkVariationInput?.toJson(),
        "menu_order": menuOrder,
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x)),
        "custom_fields": customFields?.toJson(),
        "bill_of_materials": billOfMaterials == null ? [] : List<dynamic>.from(billOfMaterials!.map((x) => x)),
        "shipping_class_id": shippingClassId,
        "product_sku": productSku,
        "uom": uom,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
      };
}