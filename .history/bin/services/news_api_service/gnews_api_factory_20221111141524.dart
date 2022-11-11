import '../../models/news_model.dart';
import '../news_service.dart';
import 'news_api_interface.dart';
import '../../utils/strings.dart';
import '../../utils/api_key.dart';

class GNewsApiFactory extends NewsApiInterface {
  String? query, author;
  int numberOfArticles = 100;

  GNewsApiFactory({this.query, this.author, this.numberOfArticles = 100}) : super(ch');

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

  @override
  Future<NewsFeed> getNewsArticles() async {
    String url =
        "${gNewsUrl}top-headlines?lang=en&token=$gnewsApiKey&max=$numberOfArticles";
    var response = await NewsService.getNews(url);
    return _getFeedFromGNewsJson(response.data!);
  }

  @override
  Future<NewsFeed> queryNewsArticles() async {
    String url =
        "${gNewsUrl}search?q=$query&token=$gnewsApiKey&lang=en&country=us&max=$numberOfArticles";
    var response = await NewsService.getNews(url);
    return _getFeedFromGNewsJson(response.data!);
  }
  
  @override
  Future<NewsFeed> queryNewsArticlesFromAuthor() async {
    String url =
        "${gNewsUrl}search?q=$query&token=$gnewsApiKey&lang=en&country=us&max=$numberOfArticles";
    var response = await NewsService.getNews(url);
    return _getFeedFromGNewsJson(response.data!);
  }
}
