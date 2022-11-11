import 'dart:convert';

import 'package:shelf/shelf.dart';
import '../services/implementation.dart';
import '../services/news_api_service/gnews_api_factory.dart';
import '../services/news_api_service/news_api_interface.dart';
import '../utils/strings.dart';

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

NewsApiInterface getInterface(Request request) {
  if (request.url.queryParameters["source"] == nytimesKey) {
    return GNewsApiFactory(
      query: request.url.queryParameters["search"],
      numberOfArticles:
          int.parse(request.url.queryParameters["count"] ?? "100"),
      author: request.url.queryParameters["author"],
    );
  }
  return GNewsApiFactory(
    query: request.url.queryParameters["search"],
    numberOfArticles: int.parse(request.url.queryParameters["count"] ?? "100"),
    author: request.url.queryParameters["author"],
  );
}

Future<Response> newsHandler(Request request) async {
  print(request.url.queryParameters);
  final news = await getInterface(request).getNewsArticles();
  return Response.ok(jsonEncode(news));
}

Future<Response> searchHandler(Request request) async {
  print(request.url.queryParameters);

  final news = await getInterface(request).getNewsArticles();

  return Response.ok(jsonEncode(news));
}
