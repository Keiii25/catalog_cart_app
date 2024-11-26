class ProductImage {
  String? src;
  String? srcSmall;
  String? srcMedium;
  String? srcLarge;
  String? youtubeVideoUrl;

  ProductImage({
    this.src,
    this.srcSmall,
    this.srcMedium,
    this.srcLarge,
    this.youtubeVideoUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        src: json["src"],
        srcSmall: json["src_small"],
        srcMedium: json["src_medium"],
        srcLarge: json["src_large"],
        youtubeVideoUrl: json["youtube_video_url"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "src_small": srcSmall,
        "src_medium": srcMedium,
        "src_large": srcLarge,
        "youtube_video_url": youtubeVideoUrl,
      };
}
