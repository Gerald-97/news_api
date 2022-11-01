class NewsImplementation {
  Future<Map<String, dynamic>> getNewsHeadlines() async {
    final news = await NewsService.getHeadlineNews();
  logPrint(news);
  }
}