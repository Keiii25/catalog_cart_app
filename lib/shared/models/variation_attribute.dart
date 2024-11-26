import '../../core/enums.dart';

class VariationAttribute {
  int? id;
  Name? name;
  Slug? slug;
  String? option;

  VariationAttribute({
    this.id,
    this.name,
    this.slug,
    this.option,
  });

  factory VariationAttribute.fromJson(Map<String, dynamic> json) => VariationAttribute(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        slug: slugValues.map[json["slug"]]!,
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "slug": slugValues.reverse[slug],
        "option": option,
      };
}
