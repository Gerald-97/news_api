import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import '../models/service_model.dart';

class NewsService {
  static Future<ServiceResponse<RssFeed>> getHeadlineNews(String url,
      {String? site}) async {
    http.Response res = await http.get(Uri.parse(url));
    print(res.body);
    if (res.statusCode < 300) {
      var response = jsonDecode(res.body);
      var result = RssFeed.parse(response);
      print(result);
      return ServiceResponse<RssFeed>(
        status: true,
        message: "News fetched successfully",
        data: result,
      );
    } else {
      return ServiceResponse<RssFeed>(
        status: false,
        message: "Something went wrong, Please try again",
      );
    }
  }
}
