import '../../models/news_model.dart';

abstract class NewsApiInterface {
  Future<NewsFeed> getNewsArticles();
  <NewsFeed> queryNewsArticles();
}
