import '../../models/news_model.dart';
import 'news_api_interface.dart';
import '../../utils/strings.dart';
import '../../utils/api_key.dart';

class GNewsApiFactory extends NewsApiInterface {
  String? query;
  int numberOfArticles = 100;

  GNewsApiFactory({this.query, this.numberOfArticles = 100});

  @override
  NewsFeed getNewsArticles() {
    String url = "$gNewsUrltop-headlines?lang=en&token=$gnewsApiKey"";
  }
  

  @override
  NewsFeed queryNewsArticles() {
    String url =
        "$gNewsUrl${query != null ? "search?q=$search&token=$gnewsApiKey&lang=en&country=us&max=20" : "top-headlines?lang=en&token=$gnewsApiKey"}";
    throw UnimplementedError();
  }
}
