import 'package:flutter/material.dart';
import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/news/data/models/news_response/news_response.dart';

class NewsViewModel with ChangeNotifier {
NewsDataSource newsDataSource = NewsDataSource();
List<Article> articles = [];
String? errorMessage;
bool isLoading = false;
  Future <void> getnews(String sourceid) async {
    isLoading=true;
   try{ NewsResponse response = await newsDataSource.getnews(sourceid);
   if(response.articles!=null&& response.status=="ok"){
     articles = response.articles! ;
     isLoading=false;
   }
   else{
    errorMessage="Failed to load news";
    isLoading=false;
   }
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
      NewsResponse response = await newsDataSource.getnewsforsearch(query, page);
      if (response.articles != null && response.status == "ok") {
        articles = response.articles!;
      } else {
        errorMessage = "Failed to load search results";
      }
    } catch (e) {
      errorMessage = "Failed to load search results";
    }
    isLoading = false;
    notifyListeners();
    return articles;
  }

  
}