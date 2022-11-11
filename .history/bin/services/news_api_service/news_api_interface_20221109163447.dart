import '../../models/news_model.dart';

abstract class NewsApiInterface {
  String? query; 
  int number

  NewsFeed getNewsArticles();
  NewsFeed queryNewsArticles(String query);
}
