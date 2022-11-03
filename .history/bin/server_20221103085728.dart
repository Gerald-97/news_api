import 'dart:io';

import 'package:redis_dart/redis_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'router/router.dart';

// Configure routes.

late RedisClient redisClient;
String? mainUrl;

void main(List<String> args) async {

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  redisClient = await RedisClient.connect("localhost");

  print('Server listening on port ${server.port}');
}
