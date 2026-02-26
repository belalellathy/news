import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:news/news/data/models/news_response/article.dart';

import 'package:news/news/view/widgets/news_item.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news/news/view_model/news_state.dart';
import 'package:news/news/view_model/news_view_model.dart';

import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
 const  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  int _currentPage = 1;
  NewsViewModel newsViewModel =NewsViewModel();

  Future<List<Article>> _fetchPage(int pageKey) async {

    
  if (_searchQuery.isNotEmpty) {
    
   await newsViewModel.getnewsforsearch(_searchQuery, pageKey);
   if(newsViewModel.errorMessage!=null){
     throw Exception(newsViewModel.errorMessage);
     }else{return newsViewModel.articles;}

  }
  else{return[];}


}

    late final PagingController<int, Article> _pagingController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  
  
  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    
    super.dispose();

  }
@override
void initState() {
  super.initState();

  _pagingController = PagingController<int, Article>(
    fetchPage: _fetchPage,
     getNextPageKey: (lastFetchedItems) {
    if (lastFetchedItems.hasNextPage==false) return null;
    return _currentPage += 1; // you manage _currentPage manually
  },
  );
}


  void _onSearchChanged(String value) {
    setState(() {
    //  _searchQuery = value== "" ? "B" : value;
      _searchQuery =  value;
     
      _pagingController.refresh();
      _currentPage = 1;
      
    });
  }


  
 
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => newsViewModel,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                 
                  suffixIconColor: settingsProvider.isDark
                      ? Colors.white
                      : Colors.black,
                  prefixIconColor: settingsProvider.isDark
                      ? Colors.white
                      : Colors.black,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        
                      },
                      icon: Icon(Icons.close)),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: settingsProvider.isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                  filled: false,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    
                    borderRadius: BorderRadius.circular(16),
                   
                  ),
                ),
                style: TextStyle(
                  color: settingsProvider.isDark?Colors.white:Colors.black,
                ),
              ),
            ),
            BlocBuilder<NewsViewModel, NewsState>(
              builder: (context, state) {
                
                return Expanded(
                  child: PagingListener(
                    controller: _pagingController,
                    builder: (context, state, fetchNextPage) =>
                        PagedListView<int, Article>(
                        
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate<Article>(
                      itemBuilder: (context, item, index) =>
                          NewsItem(article: item),
                          
                              
                      animateTransitions: true,
                      noItemsFoundIndicatorBuilder: (_) => Center(
                        child: Text("No articles found.",
                          style: TextStyle(
                            color: settingsProvider.isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (_) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Error loading data.",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _pagingController.refresh,
                              child: Text("Retry"),
                            ),
                          ],
                        ),
                      ),
                      newPageErrorIndicatorBuilder: (_) => Center(
                        child: ElevatedButton(
                          onPressed: fetchNextPage,
                          child: Text("Retry loading more"),
                        ),
                      ),
                    ),
                  ),
                                ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}