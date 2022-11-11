import '../../models/news_model.dart';

abstract class NewsApiInterface {
  String? query;
  int numberOfArticles = 100;

  NewsFeed getNewsArticles();
  NewsFeed queryNewsArticles();
  
}
