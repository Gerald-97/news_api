import 'dart:convert';

import 'package:redis_dart/redis_dart.dart';

import '../server.dart';
import '../services/news_service.dart';
import '../utils/logger.dart';
import '../utils/strings.dart';

class NewsImplementation {
  static Future<String> getNewsHeadlines({String site = }) async {

    String url = "$gNewsUrl?lang=en&token=${env[gNewsToken]}";



    final news = await NewsService.getHeadlineNews();
    if (news.status) {
      redisClient.set(gNewsToken, news.data?.toJson());

      return jsonEncode(news.data!.toJson());
    }
    return jsonEncode({"message": news.message});
  }
}
