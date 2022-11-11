import '../../models/news_model.dart';

abstract class NewsApiInterface {
  NewsFeed getNewsArticles( ]);
  NewsFeed queryNewsArticles(String query);
}
