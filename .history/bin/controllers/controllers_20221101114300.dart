import 'dart:convert';

import 'package:html/parser.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/implementation.dart';
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

  var document = parse('<body>$news</body>');

  return Response.ok(document);
}
