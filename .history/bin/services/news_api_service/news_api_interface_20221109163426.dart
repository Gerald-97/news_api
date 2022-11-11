import '../../models/news_model.dart';

abstract class NewsApiInterface {
  NewsFeed getNewsArticles([String? query, int ]);
  NewsFeed queryNewsArticles(String query);
}
