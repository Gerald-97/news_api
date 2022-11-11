import '../../models/news_model.dart';
import 'news_api_interface.dart';

class NyTimesApiFactory extends NewsApiInterface {
  String? query, author;
  int numberOfArticles = 100;

  NyTimesApiFactory({this.query, this.author, this.numberOfArticles = 100});

  static NewsModel _getModelFromGNewsJson(Map<String, dynamic> json) =>
      NewsModel(
        title: json["title"],
        content: json["content"],
        subTitle: json["description"],
        publishDate: DateTime.tryParse(json["publishedAt"]),
        url: json["url"],
        image: json["image"],
        source: json["source"]["name"],
      );

  static NewsFeed _getFeedFromGNewsJson(Map<String, dynamic> json) => NewsFeed(
        feed: json["articles"] == null || json["articles"].isEmpty
            ? []
            : List<NewsModel>.from(
                json["articles"].map((x) => _getModelFromGNewsJson(x)),
              ).toList(),
      );

  factory NewsModel.fromNYTewsJson(Map<String, dynamic> json) => NewsModel(
        title: json["headline"]["main"],
        content: json["lead_paragraph"],
        subTitle: json["snippet"],
        publishDate: DateTime.tryParse(json["pub_date"]),
        url: json["web_url"],
        image: json["multimedia"].isNotEmpty
            ? (json["multimedia"] as List).first["url"]
            : "",
        source: json["source"],
        tags:
            List<String>.from(json["keywords"].map((x) => x["value"])).toList(),
      );

  @override
  Future<NewsFeed> getNewsArticles() {
    // TODO: implement getNewsArticles
    throw UnimplementedError();
  }

  @override
  Future<NewsFeed> queryNewsArticles() {
    // TODO: implement queryNewsArticles
    throw UnimplementedError();
  }

  @override
  Future<NewsFeed> queryNewsArticlesFromAuthor() {
    // TODO: implement queryNewsArticlesFromAuthor
    throw UnimplementedError();
  }
}
