import 'package:shelf/shelf.dart';
import '../services/implementation.dart';

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> newsHandler(Request request) async {
  print(request.url.queryParameters);
  final _gNews = GNew
  final news = await NewsImplementation.getNewsHeadlines(
    site: request.url.queryParameters["site"],
    searchParam: request.url.queryParameters["search"],
  );

  return Response.ok(news.toString());
}
