import '../utils/strings.dart';

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

  factory NewsFeed.fromNYTewsJson(Map<String, dynamic> json) => ;

  Map<String, dynamic> toJson() => {
        "news_articles": List<dynamic>.from(feed.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "NewsFeed{news_articles: $feed}";
  }
}
