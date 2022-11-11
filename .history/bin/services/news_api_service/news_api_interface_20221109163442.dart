import '../../models/news_model.dart';

abstract class NewsApiInterface {
  String? query; 
  int

  NewsFeed getNewsArticles();
  NewsFeed queryNewsArticles(String query);
}
