import 'package:flutter/material.dart';
import 'package:news/sources/data/data_sources/source_data_source.dart';
import 'package:news/sources/data/models/sources_response/source.dart';
import 'package:news/sources/data/models/sources_response/sources_response.dart';

class SourcesViewModel with ChangeNotifier {
  bool isLoading = false;
  bool error = false;
List<Source> sources=[];
SourceDataSource sourceDataSource = SourceDataSource();

  Future<void> fetchSources(String categoryId) async {
    isLoading = true;
    try{
    SourcesResponse sourcesResponse= await sourceDataSource.getsources(categoryId);
    sources = sourcesResponse.sources??[];
    isLoading = false;
    notifyListeners();}
    catch(e){
      error = true;
      notifyListeners();
    }
  }
}