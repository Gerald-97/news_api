import 'news_api_interface.dart';

class NyTimesApiFactory extends NewsApiInterface {
  String? query, author;
  int numberOfArticles = 100;

  NyTimesApiFactory({this.query, this.author, this.numberOfArticles = 100});
}
