class Dimensions {
  dynamic height;
  dynamic width;
  dynamic length;

  Dimensions({
    this.height,
    this.width,
    this.length,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        height: json["height"],
        width: json["width"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "length": length,
      };
}
