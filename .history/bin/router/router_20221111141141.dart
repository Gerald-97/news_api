import 'package:shelf_router/shelf_router.dart';
import '../controllers/controllers.dart';

final router = Router()
  ..get('/', rootHandler)
  ..get('/news', newsHandler)
  ..get('/news/search', newsHandler);
