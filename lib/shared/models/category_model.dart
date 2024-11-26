class Category {
  int? id;
  int? parentId;
  String? name;
  bool? indirect;

  Category({
    this.id,
    this.parentId,
    this.name,
    this.indirect,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        indirect: json["indirect"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "indirect": indirect,
      };
}
