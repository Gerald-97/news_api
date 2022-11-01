import 'package:shelf_router/shelf_router.dart';
import '../controllers/controllers.dart';

final router = Router()
  ..get('/', rootHandler)
  ..get('/echo/<message>', echoHandler)
  ..get('/news/', newsHandler);
