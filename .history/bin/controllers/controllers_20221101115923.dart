import 'package:shelf/shelf.dart';
import '../services/implementation.dart';

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> newsHandler(Request request) async {


  // else
  final news = await NewsImplementation.getNewsHeadlines();

  return Response.ok(news.toString());
}
