import 'dart:io';

import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'services/news_service.dart';
import 'utils/logger.dart';

late DotEnv dotEnv;

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/news/', _newsHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _newsHandler(Request request) async {
  final news = await NewsService.getHeadlineNews();
  logPrint(news);
  return Response.ok("news.data");
}

void main(List<String> args) async {
  logPrint("Starting server");
  dotEnv = DotEnv(filePath: '.env');
    logPrint("Launched env");

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
    logPrint("Built server ip");

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);
      logPrint("Built server ip");

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  logPrint('Server listening on port ${server.port}');
}
