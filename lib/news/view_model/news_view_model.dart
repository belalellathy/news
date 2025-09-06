import 'package:flutter/material.dart';

import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/reposatries/news_reposatry.dart';
import 'package:news/shared/service_locator.dart';


class NewsViewModel with ChangeNotifier {
NewsRepository newsRepository = NewsRepository(ServiceLocator.newsDataSource);
List<Article> articles = [];
String? errorMessage;
bool isLoading = false;
  Future <void> getnews(String sourceid) async {
    isLoading=true;
   try{
    articles.clear();
     articles = await newsRepository.getNews(sourceid);
  }
    catch (e) {
      errorMessage="Failed to load news";
      isLoading=false;
      
    }
    isLoading =false;
    
    notifyListeners();
  }
  Future<List<Article>> getnewsforsearch(String query, int page) async {
    isLoading = true;
    try {
      articles = await newsRepository.searchNews(query, page);
    } catch (e) {
      errorMessage = "Failed to load search results";
    }
    isLoading = false;
    notifyListeners();
    return articles;
  }

  
}