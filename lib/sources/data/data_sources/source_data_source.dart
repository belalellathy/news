import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/shared/APIConst.dart';
import 'package:news/sources/data/models/sources_response/sources_response.dart';

class SourceDataSource {

   Future<SourcesResponse> getsources(String categoryid)async{
  
  Uri uri= Uri.https(APIConst.baseUrl,APIConst.sourcesEndpoint, {
    "apiKey":APIConst.apiKey ,
    "category": categoryid 
  },);
  http.Response response= await http.get(uri);
 Map<String, dynamic> json = jsonDecode (response.body);
 return SourcesResponse.fromJson(json);
 
 }
}