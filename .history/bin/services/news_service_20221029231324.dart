import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';
import '../models/service_model.dart';
import '../server.dart';

class NewsService {
  static Future<ServiceResponse<List<NewsModel>>> getHeadlineNews() async {
    String token = dotEnv.getDotEnv()["GNEWS_TOKEN"] ?? "";
    print("Token: $token");
    String url = "https://gnews.io/api/v4/top-headlines?lang=en&token=$token";
    print("Url: $token");

    http.Response res = await http.get(Uri.parse(url));
    print(res.body);
    if (res.statusCode < 300) {
      var response = jsonDecode(res.body);

      if (response["articles"] != null) {
        List<NewsModel> list = [];
        for (var item in response["articles"]) {
          list.add(NewsModel.fromGNewsJson(item));
        }

        return ServiceResponse<List<NewsModel>>(
          status: true,
          message: "News fetched successfully",
          data: list,
        );
      }

      return ServiceResponse<List<NewsModel>>(
        status: false,
        message: "No news articles",
      );
    }

    return ServiceResponse<List<NewsModel>>(
      status: false,
      message: jsonDecode(res.body)["message"],
    );
  }
}
