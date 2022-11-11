import '../../models/news_model.dart';
import 'news_api_interface.dart';

class GNewsApiFactory extends NewsApiInterface {
  int numberOfArticles = 100;
  String? searchparam;
  GNewsApiFactory({this.searchparam, this.});


  @override
  NewsFeed getNewsArticles() {
    
  }

  @override
  NewsFeed queryNewsArticles() {
    // TODO: implement queryNewsArticles
    throw UnimplementedError();
  }

} 