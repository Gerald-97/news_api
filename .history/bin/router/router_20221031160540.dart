import 'package:shelf_router/shelf_router.dart';

final _router = Router()
  ..get('/', rootHandler)
  ..get('/echo/<message>', echoHandler)
  ..get('/news/', newsHandler);
