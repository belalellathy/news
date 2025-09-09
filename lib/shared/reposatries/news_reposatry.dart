import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/news/data/models/news_response/article.dart';

class NewsRepository {
  final NewsDataSource newsDataSource;

  NewsRepository(this.newsDataSource);

  Future<List<Article>> getNews(String sourceId) async {
    return await newsDataSource.getnews(sourceId);
  }

  Future<List<Article>> searchNews(String query, int page) async {
    return await newsDataSource.getnewsforsearch(query, page);
  }
}