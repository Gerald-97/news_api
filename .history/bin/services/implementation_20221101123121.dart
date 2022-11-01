import 'dart:convert';
import 'dart:developer';

import '../server.dart';
import '../utils/logger.dart';
import 'news_service.dart';
import '../utils/strings.dart';

class NewsImplementation {
  static Future<String> getNewsHeadlines(
      {String? site = gNews, String? searchParam}) async {
    late String url;

    if (site == nytNews) {
      url =
          "$nytimesUrl?q=${searchParam ?? "headline"}&api-key=${env[nytimesApiKey]}";
    }
    url =
        "$gNewsUrl${searchParam != null ? "search?q=$searchParam" : "top-headlines"}lang=en&token=${env[gNewsToken]}";
    print(url);

    return await redisClient.getMap(url).then((value) {
      if (value.value.isEmpty) {
        throw value;
      }
      return jsonEncode(value.toString());
    }, onError: (err) async {
      final news = await NewsService.getHeadlineNews(url);
      if (news.status && news.data!.feed.isNotEmpty) {
        redisClient.setMap(url, news.data!.toJson());

        return jsonEncode(news.data!.toJson());
      }
      return jsonEncode({"message": news.message});
    });
  }
}
