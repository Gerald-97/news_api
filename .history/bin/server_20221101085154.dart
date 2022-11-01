import 'dart:io';

import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:redis_dart/redis_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'router/router.dart';

// Configure routes.

Future<RedisClient> redisClient = RedisClient.connect("host");

void main(List<String> args) async {
  late DotEnv dotEnv = DotEnv(filePath: '.env');
  

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
