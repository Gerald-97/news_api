import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';
import '../models/service_model.dart';
import '../server.dart';
import '../utils/strings.dart';

class NewsService {
  static Future<ServiceResponse<List<NewsModel>>> getHeadlineNews() async {
    print("Url: $gNewsUrl");
    dotEnv.get(gNewsToken);

    http.Response res = await http.get(Uri.parse(gNewsUrl));
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
        message: response["errors"].toString(),
      );
    }

    return ServiceResponse<List<NewsModel>>(
      status: false,
      message: jsonDecode(res.body)["message"],
    );
  }
}
