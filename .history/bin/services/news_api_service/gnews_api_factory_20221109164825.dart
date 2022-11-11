import 'dart:web_gl';

import 'package:test/test.dart';

import '../../models/news_model.dart';
import 'news_api_interface.dart';

class GNewsApiFactory extends NewsApiInterface {
  String? query;
  int numberOfArticles = 100;

  GNewsApiFactory({this.query, this.numberOfArticles});

  @override
  NewsFeed getNewsArticles() {}

  @override
  NewsFeed queryNewsArticles() {
    // TODO: implement queryNewsArticles
    throw UnimplementedError();
  }
}
