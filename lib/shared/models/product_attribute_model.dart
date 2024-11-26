import '../../core/enums.dart';

class ProductAttribute {
  int? id;
  Name? name;
  Slug? slug;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  ProductAttribute({
    this.id,
    this.name,
    this.slug,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        slug: slugValues.map[json["slug"]]!,
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "slug": slugValues.reverse[slug],
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
      };
}