import 'dart:convert';

import '../models/news_model.dart';
import '../models/service_model.dart';
import '../server.dart';
import 'news_service.dart';
import '../utils/strings.dart';

class NewsImplementation {
  Future<String> getNewsHeadlines(
      {String? site = gNews, String? searchParam}) async {
    late String url;

    if (site == nytNews) {
      url =
          "$nytimesUrl?q=${searchParam ?? "headline"}&api-key=${env[nytimesApiKey]}";
    }
    url =
        "$gNewsUrl${searchParam != null ? "search?q=$searchParam" : "top-headlines"}?lang=en&token=${env[gNewsToken]}";
    print(url);

    return await redisClient.getMap(url).then((value) {
      if (value.value.isEmpty) {
        return callService(url);
      }
      return jsonEncode(value.toString());
    }, onError: (err) async {
      return callService(url);
    });
  }

  static ServiceResponse<NewsFeed> callService(String url) async {
    final news = await NewsService.getHeadlineNews(url);
    if (news.status && news.data!.feed.isNotEmpty) {
      redisClient.setMap(url, news.data!.toJson());

      return jsonEncode(news.data!.toJson());
    }
    return jsonEncode({"message": news.message});
  }
}
