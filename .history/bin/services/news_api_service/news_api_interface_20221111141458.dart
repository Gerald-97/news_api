import '../../models/news_model.dart';

abstract class NewsApiInterface {
  String? channel;
  NewsApiInterface({required this.channel});
  Future<NewsFeed> getNewsArticles();
  Future<NewsFeed> queryNewsArticles();
  Future<NewsFeed> queryNewsArticlesFromAuthor();
}
