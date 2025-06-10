import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/API/APIConst.dart';
import 'package:news/models/news_response/news_response.dart';
import 'package:news/models/sources_response/sources_response.dart';
class ApiService {
 static Future<SourcesResponse> getsources(String categoryid)async{
  Uri uri= Uri.https(APIConst.baseUrl,APIConst.sourcesEndpoint, {
    "apiKey":APIConst.apiKey ,
    "category": categoryid 
  },);
  http.Response response= await http.get(uri);
 Map<String, dynamic> json = jsonDecode (response.body);
 return SourcesResponse.fromJson(json);
 }
 static Future<NewsResponse> getnews(String sourceid)async{
  Uri uri= Uri.https(APIConst.baseUrl,APIConst.newsEndpoint, {
    "apiKey":APIConst.apiKey ,
    "sources": sourceid 
  },);
  http.Response response= await http.get(uri);
  response.body;
  Map<String, dynamic> json = jsonDecode (response.body);
  return NewsResponse.fromJson(json);
}
}