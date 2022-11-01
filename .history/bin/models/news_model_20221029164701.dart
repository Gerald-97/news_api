class NewsModel {
  String title, content;
  DateTime? publishDate;
  String? subTitle, url, image, source;
  List<String>? tags;

  NewsModel({
    required this.title, required this.content,
    this.publishDate, this.subTitle, this.url, this.image, this.source, this.tags
  });
}
