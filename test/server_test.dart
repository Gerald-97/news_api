import 'dart:io';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../bin/models/news_model.dart';
import '../bin/services/news_api_service/gnews_api_factory.dart';
import '../bin/services/news_api_service/news_api_interface.dart';

class MockNewsService extends Mock implements NewsApiInterface {}

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  late Process p;

  late GNewsApiFactory sut;
  late MockNewsService mockService;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  group("getArticles", () {
    final mockedNewsFeed = NewsFeed(feed: [
      NewsModel(title: 'Title 1', content: 'Content 1'),
      NewsModel(title: 'Title 2', content: 'Content 2'),
      NewsModel(title: 'Title 3', content: 'Content 3'),
    ]);

    sut = GNewsApiFactory();

    void getNewsServiceReturnsArticles() {
      when(() => sut.getNewsArticles()).thenAnswer(
        (realInvocation) => Future<NewsFeed>.value(mockedNewsFeed),
      );
    }

    test("get articles from news api", () async {
      getNewsServiceReturnsArticles();

      await sut.getNewsArticles();
      verify(() => sut.getNewsArticles()).called(1);
    });

    test("confirm loading state of test call", () async {
      getNewsServiceReturnsArticles();

      
    });
  });

  // test('Root', () async {
  //   final response = await get(Uri.parse('$host/'));
  //   expect(response.statusCode, 200);
  //   expect(response.body, 'Hello, World!\n');
  // });

  // test('404', () async {
  //   final response = await get(Uri.parse('$host/foobar'));
  //   expect(response.statusCode, 404);
  // });
}
