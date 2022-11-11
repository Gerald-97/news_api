import '../../models/news_model.dart';

abstract class NewsApiInterface {
  String? query; 
  int numberOfArticles

  NewsFeed getNewsArticles();
  NewsFeed queryNewsArticles(String query);
}
