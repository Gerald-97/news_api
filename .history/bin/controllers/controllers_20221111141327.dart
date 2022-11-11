import 'dart:convert';

import 'package:shelf/shelf.dart';
import '../services/implementation.dart';
import '../services/news_api_service/gnews_api_factory.dart';
import '../services/news_api_service/news_api_interface.dart';

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

NewsApiInterface getInterface(Request request) {
  GNewsApiFactory gNewsApiFactory = GNewsApiFactory(
    query: request.url.queryParameters["search"],
    numberOfArticles: int.parse(request.url.queryParameters["count"] ?? "100"),
    author: request.url.queryParameters["author"],
  );
}

Future<Response> newsHandler(Request request) async {
  print(request.url.queryParameters);
  final _gNews = GNewsApiFactory(
    query: request.url.queryParameters["search"],
    numberOfArticles: int.parse(request.url.queryParameters["count"] ?? "100"),
    author: request.url.queryParameters["author"],
  );

  final news = await _gNews.getNewsArticles();

  return Response.ok(jsonEncode(news));
}

Future<Response> searchHandler(Request request) async {
  print(request.url.queryParameters);
  final _gNews = GNewsApiFactory(
    query: request.url.queryParameters["search"],
    numberOfArticles: int.parse(request.url.queryParameters["count"] ?? "100"),
    author: request.url.queryParameters["author"],
  );

  final news = await _gNews.getNewsArticles();

  return Response.ok(jsonEncode(news));
}
