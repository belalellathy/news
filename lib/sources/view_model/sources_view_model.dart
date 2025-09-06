import 'package:flutter/material.dart';
import 'package:news/reposatries/sources_repsaitory.dart';
import 'package:news/shared/service_locator.dart';
import 'package:news/sources/data/models/sources_response/source.dart';


class SourcesViewModel with ChangeNotifier {
  bool isLoading = false;
  bool error = false;
List<Source> sources=[];

SourcesRepository sourcesRepository = SourcesRepository(ServiceLocator.source);

  Future<void> fetchSources(String categoryId) async {
    isLoading = true;
    try{
     sources = await sourcesRepository.getsources(categoryId);
      isLoading = false;
    notifyListeners();}
    catch(e){
      error = true;
      isLoading = false;
      notifyListeners();
    }
  }
}