import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import '../models/service_model.dart';

class NewsService {
  
  static Future<ServiceResponse<RssFeed>> getHeadlineNews(String url,
      {String? site}) async {
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode < 300) {
      // var response = jsonDecode(res.body);
      //     print(response);
      var result = RssFeed.parse(res.body);
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