
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/shared/APIConst.dart';
import 'package:news/news/data/models/news_response/news_response.dart';
class NewsApiDataSource extends NewsDataSource {
@override
  Future<List<Article>> getnews(String sourceid)async{
  
  Uri uri= Uri.https(APIConst.baseUrl,APIConst.newsEndpoint, {
    "apiKey":APIConst.apiKey ,
    "sources": sourceid ,
    "page":"1",
    "pageSize":"20",
  },);
  
  http.Response response= await http.get(uri);
  response.body;
  Map<String, dynamic> json = jsonDecode (response.body);
  NewsResponse newsResponse= NewsResponse.fromJson(json);
  if(newsResponse.status=="ok"){
    return newsResponse.articles ??[];
   
  }else{ throw Exception("Failed to load news");}
  

}



@override
 Future<List<Article>> getnewsforsearch(String query,int page)async{
    Uri uri= Uri.https(APIConst.baseUrl,APIConst.searchEndpoint, {
      "apiKey":APIConst.apiKey ,
      "q":query,
      "pageSize":"20",
      "page":"$page"

    },);
  http.Response response= await http.get(uri);
  Map<String, dynamic> json = jsonDecode (response.body);
  NewsResponse newsResponse= NewsResponse.fromJson(json);
  return newsResponse.articles ??[];
  }
}