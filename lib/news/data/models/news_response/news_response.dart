import 'article.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsResponse({this.status, this.totalResults, this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    articles: (json['articles'] as List<dynamic>?)
        ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  
}
