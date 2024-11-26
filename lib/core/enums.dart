enum LocaleType { english }
enum AppRoute { root, cart }

enum Name { UOM }
final nameValues = EnumValues({"UOM": Name.UOM});

enum Slug { UOM }
final slugValues = EnumValues({"uom": Slug.UOM});

enum CatalogVisibility { EMPTY, VISIBLE }

final catalogVisibilityValues = EnumValues({"": CatalogVisibility.EMPTY, "visible": CatalogVisibility.VISIBLE});

enum Status { PUBLISH }

final statusValues = EnumValues({"publish": Status.PUBLISH});

enum ProductType { COMPOSITE, VARIABLE }

final productTypeValues = EnumValues({"composite": ProductType.COMPOSITE, "variable": ProductType.VARIABLE});

enum VariationType { VARIATION }

final variationTypeValues = EnumValues({"variation": VariationType.VARIATION});



class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
