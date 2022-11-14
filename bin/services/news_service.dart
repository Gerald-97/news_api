import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/service_model.dart';

class NewsService {
  static Future<ServiceResponse<Map<String, dynamic>>> getNews(
      String url) async {
    print(url);
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode < 300) {
      return ServiceResponse<Map<String, dynamic>>(
        status: true,
        message: "News fetched successfully",
        data: jsonDecode(res.body),
      );
    } else {
      return ServiceResponse<Map<String, dynamic>>(
        status: false,
        message: "Something went wrong, Please try again",
        data: {},
      );
    }
  }
}
