import '../../models/news_model.dart';
import 'news_api_interface.dart';
import '../news_service.dart';
import '../../utils/strings.dart';
import '../../utils/api_key.dart';

class NyTimesApiFactory extends NewsApiInterface {
  String? query, author;
  int numberOfArticles = 100;

  NyTimesApiFactory({this.query, this.author, this.numberOfArticles = 100});

  static NewsModel _getModelFromNYTNewsJson(Map<String, dynamic> json) =>
      NewsModel(
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

  static NewsFeed _getFeedFromNYTNewsJson(Map<String, dynamic> json) =>
      NewsFeed(
        feed:
            json["response"]["docs"] == null || json["response"]["docs"].isEmpty
                ? []
                : List<NewsModel>.from(
                    json["response"]["docs"]
                        .map((x) => _getModelFromNYTNewsJson(x)),
                  ).toList(),
      );

  @override
  Future<NewsFeed> getNewsArticles() async {
    String url = "$nytimesUrl?q=headline&api-key=$nytimesApiKey";
    var response = await NewsService.getNews(url);
    return _getFeedFromNYTNewsJson(response.data!);
  }

  @override
  Future<NewsFeed> queryNewsArticles() async {
    String url = "$nytimesUrl?q=$query&api-key=$nytimesApiKey";
    var response = await NewsService.getNews(url);
    return _getFeedFromNYTNewsJson(response.data!);
  }

  @override
  Future<NewsFeed> queryNewsArticlesFromAuthor() async {
    String url = "$nytimesUrl?q=$query&api-key=$nytimesApiKey";
    var response = await NewsService.getNews(url);
    return _getFeedFromNYTNewsJson(response.data!);
  }
}
