import 'dart:convert';

import '../server.dart';
import 'news_service.dart';
import '../utils/strings.dart';

class NewsImplementation {

  static String getUrlFromParam({String? site, String? searchParam}) {
    
  }

  static Future<String> getNewsHeadlines(
      {String? site = gNews, String? searchParam}) async {
    
    print(url);

    var result = await redisClient.getMap(url);
    if (result.value.isNotEmpty) {
      print("Redis: ${result.value}");
      return jsonEncode(result.value.toString());
    } else {
      final news = await NewsService.getHeadlineNews(url, site: site);
      if (news.status && news.data!.feed.isNotEmpty) {
        redisClient.setMap(url, news.data!.toJson());

        return jsonEncode(news.data!.toJson());
      }
      return jsonEncode({"message": news.message});
    }
  }
}
