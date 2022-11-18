import 'dart:convert';

import '../../models/news_model.dart';
import '../../server.dart';
import '../news_service.dart';
import 'news_api_interface.dart';
import '../../utils/strings.dart';
import '../../utils/api_key.dart';

class GNewsApiFactory extends NewsApiInterface {
  GNewsApiFactory({query, author, numberOfArticles})
      : super(query: query, author: author, numberOfArticles: 20);

  static NewsModel _getModelFromGNewsJson(Map<String, dynamic> json) =>
      NewsModel(
        title: json["title"],
        content: json["content"],
        subTitle: json["description"],
        publishDate: DateTime.tryParse(json["publishedAt"]),
        url: json["url"],
        image: json["image"],
        source: json["source"]["name"],
      );

  static NewsFeed _getFeedFromGNewsJson(Map<String, dynamic> json) => NewsFeed(
        feed: json["articles"] == null || json["articles"].isEmpty
            ? []
            : List<NewsModel>.from(
                json["articles"].map((x) => _getModelFromGNewsJson(x)),
              ).toList(),
      );

  @override
  Future<NewsFeed> getNewsArticles() async {
    String url =
        "${gNewsUrl}top-headlines?lang=en&token=$gnewsApiKey&max=$numberOfArticles";
    print(url);
    // redisClient.expireAt(url, DateTime.now().add(Duration(minutes: 30)));
    // redisClient.delete(url);

    try {
      var result = await redisClient.getMap(url);
      print("Redis log: ${result.value.runtimeType}");
      print("Redis log decode: ${result.value}");
    } catch (e, stack) {
      print("$e\n$stack");
    }
    // var result = await redisClient.getMap(url);

    // if (result.value != null) {
    //   print("Redis value: ${result.value}");
    //   return NewsFeed.fromJson(result.value);
    // } else {
      var response = await NewsService.getNews(url);
      if (response.status) {
        var data = _getFeedFromGNewsJson(response.data!);

        await redisClient.setMap(url, data.toJson());
      }
      return _getFeedFromGNewsJson(response.data!);
    // }
  }

  @override
  Future<NewsFeed> queryNewsArticles() async {
    String url =
        "${gNewsUrl}search?q=$query&token=$gnewsApiKey&lang=en&country=us&max=$numberOfArticles";
    var response = await NewsService.getNews(url);
    return _getFeedFromGNewsJson(response.data!);
  }

  @override
  Future<NewsFeed> queryNewsArticlesFromAuthor() async {
    String url =
        "${gNewsUrl}search?q=$author&token=$gnewsApiKey&lang=en&country=us&max=$numberOfArticles";
    var response = await NewsService.getNews(url);
    return _getFeedFromGNewsJson(response.data!);
  }
}
