import 'dart:convert';

import '../server.dart';
import 'news_service.dart';
import '../utils/strings.dart';
import '../utils/api_key.dart';

class NewsImplementation {
  static String getUrlFromParam({String? site = gnewsKey, String? search}) {
    if (site == nytimesKey) {
      return "$nytimesUrl?q=${search ?? "headline"}&api-key=$nytimesApiKey";
    }
    return "$gNewsUrl${search != null ? "search?q=$search&token=$gnewsApiKey&lang=en&country=us&max=20" : "top-headlines?lang=en&token=$gnewsApiKey"}";
  }

  static Future<String> getNewsHeadlines(
      {String? site, String? searchParam}) async {
    String url = getUrlFromParam(site: site, search: searchParam);
    print(url);

    var result = await redisClient.getMap(url);
    if (result.value.isNotEmpty) {
      return jsonEncode(result.value.toString());
    } else {
      final news = await NewsService.getHeadlineNews(url, site: site);
      if (news.status) {
        redisClient.setMap(url, jsonEncode(news.data.toStrin));

        return jsonEncode(news.data!.toJson());
      }
      return jsonEncode({"message": news.message});
    }
  }
}
