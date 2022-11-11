import '../../models/news_model.dart';

abstract class NewsApiInterface {
  NewsFeed getNewsArticles([String ]});
  NewsFeed queryNewsArticles(String query);
}
