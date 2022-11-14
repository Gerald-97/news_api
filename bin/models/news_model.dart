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

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"],
        content: json["content"],
        image: json["image"],
        publishDate: DateTime.parse(json["publish_date"]),
        source: json["source"],
        subTitle: json["sub_title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "sub_title": subTitle,
        "publish_date": publishDate?.toIso8601String(),
        "url": url,
        "image": image,
        "source": source,
        "tags": tags == null ? [] : List<String>.from(tags!.map((e) => e)),
      };

  @override
  String toString() {
    return "NewsModel{title: $title, content: $content, subTitle: $subTitle, publishDate: $publishDate, url: $url, image: $image, source: $source}";
  }
}

class NewsFeed {
  List<NewsModel> feed;

  NewsFeed({required this.feed});

  factory NewsFeed.fromJson(Map<String, dynamic> json) => NewsFeed(
        feed: List<NewsModel>.from(
            json["news_articles"].map((x) => NewsModel.fromJson(x)).toList()),
      );

  Map<String, dynamic> toJson() => {
        "news_articles": List<dynamic>.from(feed.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "NewsFeed{news_articles: $feed}";
  }
}
