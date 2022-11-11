import '../../models/news_model.dart';

abstract class NewsApiInterface {
  String? channel;
  NewsApiInterface({this.})
  Future<NewsFeed> getNewsArticles();
  Future<NewsFeed> queryNewsArticles();
  Future<NewsFeed> queryNewsArticlesFromAuthor();
}
