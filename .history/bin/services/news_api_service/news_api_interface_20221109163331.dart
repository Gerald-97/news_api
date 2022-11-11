import '../../models/news_model.dart';

abstract class NewsApiInterface {
  NewsFeed getNewsArticles({int numberOfArticles});
  NewsFeed queryNewsArticles(String query);
}
