import 'package:test/test.dart';

import '../../models/news_model.dart';
import 'news_api_interface.dart';

class GNewsApiFactory extends NewsApiInterface {
  GNewsApiFactory() : super(query, numberOfArticles );


  @override
  NewsFeed getNewsArticles() {
    
  }

  @override
  NewsFeed queryNewsArticles() {
    // TODO: implement queryNewsArticles
    throw UnimplementedError();
  }

} 