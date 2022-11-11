import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/news_model.dart';
import '../../models/service_model.dart';
import 'news_api_interface.dart';
import '../../utils/strings.dart';
import '../../utils/api_key.dart';

class GNewsApiFactory extends NewsApiInterface {
  String? query;
  int numberOfArticles = 100;

  GNewsApiFactory({this.query, this.numberOfArticles = 100});

  static NewsModel _getModelromGNewsJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"],
        content: json["content"],
        subTitle: json["description"],
        publishDate: DateTime.tryParse(json["publishedAt"]),
        url: json["url"],
        image: json["image"],
        source: json["source"]["name"],
      );

  static Future<ServiceResponse<NewsFeed>> _getNews(String url) async {
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode < 300) {
      var response = jsonDecode(res.body);
      print(response);
      var result = NewsFeed.fromGNewsJson(response);
      print(result);
      return ServiceResponse<NewsFeed>(
        status: true,
        message: "News fetched successfully",
        data: result,
      );
    } else {
      return ServiceResponse<NewsFeed>(
        status: false,
        message: "Something went wrong, Please try again",
        data: NewsFeed(feed: []),
      );
    }
  }

  @override
  Future<NewsFeed> getNewsArticles() async {
    String url =
        "${gNewsUrl}top-headlines?lang=en&token=$gnewsApiKey&max=$numberOfArticles";

    return (await _getNews(url)).data!;
  }

  @override
  Future<NewsFeed> queryNewsArticles() async {
    String url =
        "${gNewsUrl}search?q=$query&token=$gnewsApiKey&lang=en&country=us&max=$numberOfArticles";
    return (await _getNews(url)).data!;
  }
}
