import 'dart:convert';

import '../server.dart';
import 'news_service.dart';
import '../utils/strings.dart';

class NewsImplementation {
  static String getUrlFromParam({String? site, String? se}) {
    late String url;

    if (site == nytimesKey) {
      return url =
          "$nytimesUrl?q=${searchParam ?? "headline"}&api-key=${env[nytimesKey]}";
    }
    return url =
        "$gNewsUrl${searchParam != null ? "search?q=$searchParam&token=${env[gnewsKey]}&lang=en&country=us&max=20" : "top-headlines?lang=en&token=${env[gnewsKey]}"}";
  }

  static Future<String> getNewsHeadlines(
      {String? site, String? searchParam}) async {
        String url = getUrlFromParam(site: site, searchParam: searchParam);
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
