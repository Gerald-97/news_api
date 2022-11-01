import 'dart:convert';

import 'package:redis_dart/redis_dart.dart';
import 'package:shelf/shelf.dart';

import '../server.dart';
import '../services/news_service.dart';
import '../utils/logger.dart';
import '../utils/strings.dart';

Middleware setUrl(Request req) {
  String site = req.url.queryParameters["site"] ?? gNews;
  String? search = req.url.queryParameters["search"];

  late String url;

  if (site == nytNews) {
    url = "$nytimesUrl?q=${search ?? "headline"}&api-key=${env[nytimesApiKey]}";
  }
  url =
      "$gNewsUrl${search != null ? "search?q=$search" : "top-headlines"}?lang=en&token=${env[gNewsToken]}";

  req.url = Uri.parse(url);

  return req;
}

class NewsImplementation {
  static Future<String> getNewsHeadlines(
      {String site = gNews, String? searchParam}) async {
    late String url;

    if (site == nytNews) {
      url =
          "$nytimesUrl?q=${searchParam ?? "headline"}&api-key=${env[nytimesApiKey]}";
    }
    url =
        "$gNewsUrl${searchParam != null ? "search?q=$searchParam" : "top-headlines"}?lang=en&token=${env[gNewsToken]}";

    redisClient.getMap(site);

    var result = await redisClient.getMap(site);
    final news = await NewsService.getHeadlineNews(url);
    if (news.status && news.data!.feed.isNotEmpty) {
      redisClient.setMap(site, news.data!.toJson());

      return jsonEncode(news.data!.toJson());
    }
    return jsonEncode({"message": news.message});
  }
}
