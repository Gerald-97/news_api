import 'dart:convert';

import '../server.dart';
import 'news_service.dart';
import '../utils/strings.dart';

class NewsImplementation {
  static String getUrlFromParam({String? site = gnewsKey, String? search}) {
    env = DotEnv(includePlatformEnvironment: true)..load();
    if (site == nytimesKey) {
      return "$nytimesUrl?q=${search ?? "headline"}&api-key=${env[site!]}";
    }
    return "$gNewsUrl${search != null ? "search?q=$search&token=${env[site!]}&lang=en&country=us&max=20" : "top-headlines?lang=en&token=${env[site!]}"}";
  }

  static Future<String> getNewsHeadlines(
      {String? site, String? searchParam}) async {
    String url = getUrlFromParam(site: site, search: searchParam);
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
