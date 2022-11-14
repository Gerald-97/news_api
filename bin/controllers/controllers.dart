import 'dart:convert';

import 'package:shelf/shelf.dart';
import '../services/news_api_service/gnews_api_factory.dart';
import '../services/news_api_service/news_api_interface.dart';
import '../services/news_api_service/nytimes_api_factory.dart';
import '../utils/strings.dart';

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

NewsApiInterface getInterface(Request request) {
  if (request.url.queryParameters["source"] != null &&
      request.url.queryParameters["source"] == nytimesKey) {
    return NyTimesApiFactory(
      query: request.url.queryParameters["search"],
      numberOfArticles:
          int.tryParse(request.url.queryParameters["count"] ?? "20"),
      author: request.url.queryParameters["author"],
    );
  }
  return GNewsApiFactory(
    query: request.url.queryParameters["search"],
    numberOfArticles:
        int.tryParse(request.url.queryParameters["count"] ?? "20"),
    author: request.url.queryParameters["author"],
  );
}

Future<Response> newsHandler(Request request) async {
  print(request.url.queryParameters);
  final _interface = getInterface(request);
  if (_interface.query != null) {
    return Response.ok(
      jsonEncode((await _interface.queryNewsArticles()).toJson()),
    );
  }
  return Response.ok(
    jsonEncode((await _interface.getNewsArticles()).toJson()),
  );
}
