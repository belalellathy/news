import 'package:news/news/data/models/news_response/article.dart';

abstract class NewsDataSource {

  Future<List<Article>> getnews(String sourceId);
  
  Future<List<Article>> getnewsforsearch(String query, int page);
}