import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/shared/APIConst.dart';
import 'package:news/sources/data/data_sources/data_source.dart';
import 'package:news/sources/data/models/sources_response/source.dart';
import 'package:news/sources/data/models/sources_response/sources_response.dart';

class SourceDataSource extends Datasource {
@override
   Future<List<Source>> getsources(String categoryid)async{

  Uri uri= Uri.https(APIConst.baseUrl,APIConst.sourcesEndpoint, {
    "apiKey":APIConst.apiKey ,
    "category": categoryid 
  },);
  http.Response response= await http.get(uri);
 Map<String, dynamic> json = jsonDecode (response.body);
 SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
 if(sourcesResponse.status=="ok"&&sourcesResponse.sources!=null){
return sourcesResponse.sources ?? [];
 }else{
  throw Exception("Failed to load sources");
 }
 
 }
}