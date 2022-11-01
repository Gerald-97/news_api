import '../server.dart';
import '../services/news_service.dart';
import '../utils/logger.dart';

class NewsImplementation {
  Future<Map<String, dynamic>> getNewsHeadlines() async {

    final news = await NewsService.getHeadlineNews();
    redisClient.s
    logPrint(news);
  }
}
