import '../models/news_model.dart';

class NewsService {
  Future<List<NewsModel>> getHeadlineNews() async {
    String url = "https://gnews.io/api/v4/top-headlines?lang=en&token=da6ca019a0329c931bea215486781659"
  }
}