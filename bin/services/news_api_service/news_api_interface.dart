import '../../models/news_model.dart';

abstract class NewsApiInterface {
  Future<NewsFeed> getNewsArticles();
  Future<NewsFeed> queryNewsArticles();
  Future<NewsFeed> queryNewsArticlesFromAuthor();
}
