import 'package:redis_dart/redis_dart.dart';

import '../server.dart';
import '../services/news_service.dart';
import '../utils/logger.dart';

class NewsImplementation {
  Future<Map<String, dynamic>> getNewsHeadlines() async {
    final news = await NewsService.getHeadlineNews();
    final client = await RedisClient.connect("s");
    client.s
    logPrint(news);
  }
}
