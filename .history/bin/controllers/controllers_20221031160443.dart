import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/news_service.dart';
import '../utils/logger.dart';

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> newsHandler(Request request) async {
  // mae  Cll to redis server

  //  if it exists return

  // else
  final news = await NewsService.getHeadlineNews();
  logPrint(news);

// update redis
  return Response.ok(news.data);
}
