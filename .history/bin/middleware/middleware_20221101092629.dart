class NewsImplementation {
  Future<Map<String, dynamic>> getNewsHeadlines() {
    final news = await NewsService.getHeadlineNews();
  logPrint(news);
  }
}