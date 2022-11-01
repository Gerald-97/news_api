class NewsModel {
  String title, content;
  DateTime? publishDate;
  String? subTitle, url, image, source;
  List<String>? tags;

  NewsModel({
    required this.title,
    required this.content,
    this.publishDate,
    this.subTitle,
    this.url,
    this.image,
    this.source,
    this.tags,
  });

  factory NewsModel.fromGNewsJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"],
        content: json["content"],
        subTitle: json["description"],
        publishDate: DateTime.tryParse(json["publishedAt"]),
        url: json["url"],
        image: json["image"],
        source: json["source"]["name"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "sub_title": subTitle,
        "publish_date": publishDate?.toIso8601String(),
        "url": url,
        "image": image,
        "source": source,
      };

  @override
  String toString() {
    return "NewsModel{title: $title, content: $content, $subTitle, $publishDate, $url, $}";
  }
}
