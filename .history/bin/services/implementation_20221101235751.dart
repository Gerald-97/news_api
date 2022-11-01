import 'dart:convert';

import '../server.dart';
import 'news_service.dart';
import '../utils/strings.dart';

class NewsImplementation {

  static String getUrlFromParam({String? site, String? sear}) {
    
  }

  static Future<String> getNewsHeadlines(
      {String? site = gNews, String? searchParam}) async {
    late String url;

    if (site == nytNews) {
      url =
          "$nytimesUrl?q=${searchParam ?? "headline"}&api-key=${env[nytimesApiKey]}";
    } else {
      url =
          "$gNewsUrl${searchParam != null ? "search?q=$searchParam&token=${env[gNewsToken]}&lang=en&country=us&max=20" : "top-headlines?lang=en&token=${env[gNewsToken]}"}";
    }
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
