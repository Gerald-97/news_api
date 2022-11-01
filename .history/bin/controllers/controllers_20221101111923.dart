import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../middleware/middleware.dart';
import '../services/news_service.dart';
import '../utils/logger.dart';

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> newsHandler(Request request) async {
  // mae  Cll to redis server

  //  if it exists return

  // else
  final news = await NewsImplementation.getNewsHeadlines();

  return Response.ok("<h2> $news </h2>");
}
