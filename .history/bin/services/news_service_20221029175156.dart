import '../models/news_model.dart';
import '../server.dart';

class NewsService {
  Future<List<NewsModel>> getHeadlineNews() async {
    String token = env["GNEWS_TOKEN"];
    String url = "https://gnews.io/api/v4/top-headlines?lang=en&token=token";
  }
}
