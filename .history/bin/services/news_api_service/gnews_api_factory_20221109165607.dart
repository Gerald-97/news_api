import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/news_model.dart';
import '../../models/service_model.dart';
import 'news_api_interface.dart';
import '../../utils/strings.dart';
import '../../utils/api_key.dart';

class GNewsApiFactory extends NewsApiInterface {
  String? query;
  int numberOfArticles = 100;

  GNewsApiFactory({this.query, this.numberOfArticles = 100});

  @override
  NewsFeed getNewsArticles() {
    String url = "${gNewsUrl}top-headlines?lang=en&token=$gnewsApiKey";

    var
  }

  @override
  NewsFeed queryNewsArticles() {
    String url =
        "$gNewsUrl${query != null ? "search?q=$search&token=$gnewsApiKey&lang=en&country=us&max=20" : "top-headlines?lang=en&token=$gnewsApiKey"}";
    throw UnimplementedError();
  }

  static Future<ServiceResponse<NewsFeed>> getHeadlineNews(String url,
      {String? site}) async {
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode < 300) {
      var response = jsonDecode(res.body);
      print(response);
      var result = NewsFeed.fromGNewsJson(response);
      print(result);
      return ServiceResponse<NewsFeed>(
        status: true,
        message: "News fetched successfully",
        data: result,
      );
    } else {
      return ServiceResponse<NewsFeed>(
        status: false,
        message: "Something went wrong, Please try again",
      );
    }
  }
}
