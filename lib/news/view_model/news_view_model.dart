import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/news/view_model/news_state.dart';
import 'package:news/shared/reposatries/news_reposatry.dart';
import 'package:news/shared/service_locator.dart';


class NewsViewModel extends Cubit<NewsState> {
  NewsViewModel():super(NewsInitial());
NewsRepository newsRepository = NewsRepository(ServiceLocator.newsDataSource);
List<Article> articles = [];
String? errorMessage ;

bool isLoading = false;
  Future <void> getnews(String sourceid) async {
     try{
      emit(NewsLoading());
    articles.clear();
     articles = await newsRepository.getNews(sourceid);
      emit(Newssucces());
  }
    catch (e) {
      emit(NewsError(e.toString()));
    } 
  }
  Future<List<Article>> getnewsforsearch(String query, int page) async {
  emit(NewsLoading());
    try {
      articles = await newsRepository.searchNews(query, page);
      emit(Newssucces());
    } catch (e) {
      errorMessage=e.toString();
 
    }
    isLoading = false;
    return articles;
  }

  
}