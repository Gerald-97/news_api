import 'package:redis_dart/redis_dart.dart';

import '../server.dart';
import '../services/news_service.dart';
import '../utils/logger.dart';
import '../utils/strings.dart';

class NewsImplementation {
  Future<Map<String, dynamic>> getNewsHeadlines({String? url}) async {
    final news = await NewsService.getHeadlineNews();
    redisClient.set(gNewsToken, news.);

    logPrint(news);
  }
}
