import '../../models/news_model.dart';

abstract class NewsApiInterface {
  NewsFeed getNewsArticles([String? query, ]);
  NewsFeed queryNewsArticles(String query);
}
