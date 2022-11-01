import 'dart:convert';

import 'package:redis_dart/redis_dart.dart';
import 'package:shelf/shelf.dart';

import '../server.dart';
import 'news_service.dart';
import '../utils/logger.dart';
import '../utils/strings.dart';

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

    await redisClient.getMap(url).then((value) {
      return jsonEncode(value.toString());
    }, onError: (err) {

    });

    
  }
}
