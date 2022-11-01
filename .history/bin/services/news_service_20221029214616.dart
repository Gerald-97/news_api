import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';
import '../models/service_model.dart';
import '../server.dart';

class NewsService {
  Future<ServiceResponse<List<NewsModel>>> getHeadlineNews() async {
    String token = env["GNEWS_TOKEN"];
    String url = "https://gnews.io/api/v4/top-headlines?lang=en&token=$token";

    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode < 300) {
      var response = jsonDecode(res.body);

      if (response["articles"] != null && response["articles"])
      List<NewsModel> _list = [];
      for (var item in response["articles"]) {
        _list.add(NewsModel.fromGNewsJson(item));
      }

      return ServiceResponse<List<NewsModel>>(
        status: true,
        message: "News fetched successfully",
        data: _list,
      );
    }

    return ServiceResponse<List<NewsModel>>(
      status: false,
      message: jsonDecode(res.body)["message"],
    );
  }
}
