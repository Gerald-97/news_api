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

  @override
  Future<NewsFeed> getNewsArticles() async {
    String url = "${gNewsUrl}top-headlines?lang=en&token=$gnewsApiKey";

    return (await _getNews(url)).data!;
  }

  @override
  Future<NewsFeed> queryNewsArticles() async {
    String url =
        "${gNewsUrl}search?q=$query&token=$gnewsApiKey&lang=en&country=us&max=$numberOfArticles";
    return (await _getNews(url)).data!;
  }
}
