import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';
import '../models/service_model.dart';
import '../server.dart';
import '../utils/strings.dart';

class NewsService {
  static Future<ServiceResponse<NewsFeed>> getHeadlineNews(String url, {String? site}) async {
  
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode < 300) {
      var response = jsonDecode(res.body);
      return ServiceResponse<NewsFeed>(
        status: true,
        message: "News fetched successfully",
        data: NewsFeed.fromGNewsJson(response),
      );
    } else {
      return ServiceResponse<NewsFeed>(
        status: false,
        message: "Something went wrong, Please try again",
      );
    }
  }
}
