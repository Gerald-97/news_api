import 'package:redis_dart/redis_dart.dart';

import '../server.dart';
import '../services/news_service.dart';
import '../utils/logger.dart';
import '../utils/strings.dart';

class NewsImplementation {
  static Future<Map<String, dynamic>> getNewsHeadlines({String? url}) async {
    final news = await NewsService.getHeadlineNews();
    if (news.status) {
      redisClient.set(gNewsToken, news.data?.toJson());
    }
    

    logPrint(news);

    return news.toJson();
  }
}
