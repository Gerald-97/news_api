import '../../models/news_model.dart';

abstract class NewsApiInterface {
  String? query, author;
  int? numberOfArticles;

  NewsApiInterface({this.query, this.author, this.numberOfArticles});

  Future<NewsFeed> getNewsArticles();
  Future<NewsFeed> queryNewsArticles();
  Future<NewsFeed> queryNewsArticlesFromAuthor();
}
