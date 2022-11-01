import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:redis_dart/redis_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'router/router.dart';
import 'utils/strings.dart';

// Configure routes.

Future<RedisClient> redisClient = RedisClient.connect("host");
late DotEnv env;

void main(List<String> args) async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  print("Token: ${dotEnv.get(gNewsToken)}");

  env = Platform.environment;

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
