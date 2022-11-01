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

  factory NewsModel.fromGNewsJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"],
        content: json["content"],
        subTitle: json["description"],
        publishDate: DateTime.tryParse(json["publishedAt"]),
        url: json["url"],
        image: json["image"],
        source: json["source"]["name"],
      );

  factory NewsModel.fromNYTewsJson(Map<String, dynamic> json) => NewsModel(
        title: json["headline"]["main"],
        content: json["lead_paragraph"],
        subTitle: json["snippet"],
        publishDate: DateTime.tryParse(json["pub_date"]),
        url: json["web_url"],
        image: json["multimedia"][0]["url"],
        source: json["source"],
        tags:
            List<String>.from(json["keywords"].map((x) => x["value"])).toList(),
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

  factory NewsFeed.fromJson(Map<String, dynamic> json, {String? site}) {
    if (site == nytimesKey) {
      return NewsFeed.fromNYTewsJson(json);
    }
    return NewsFeed.fromGNewsJson(json);
  }

  factory NewsFeed.fromGNewsJson(Map<String, dynamic> json) => NewsFeed(
        feed: json["articles"] == null || json["articles"].isEmpty
            ? []
            : List<NewsModel>.from(
                json["articles"].map((x) => NewsModel.fromGNewsJson(x)),
              ).toList(),
      );

  factory NewsFeed.fromNYTewsJson(Map<String, dynamic> json) => NewsFeed(
        feed:
            json["response"]["docs"] == null || json["response"]["docs"].isEmpty
                ? []
                : List<NewsModel>.from(
                    json["response"]["docs"]
                        .map((x) => NewsModel.fromNYTewsJson(x)),
                  ).toList(),
      );

  Map<String, dynamic> toJson() => {
        "news_articles": List<dynamic>.from(feed.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "NewsFeed{news_articles: $feed}";
  }
}
