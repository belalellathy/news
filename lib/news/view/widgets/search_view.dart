import 'package:flutter/material.dart';



import 'package:news/news/data/models/news_response/article.dart';

import 'package:news/news/view/widgets/news_item.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news/news/view_model/news_view_model.dart';

import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
   SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  int _currentPage = 1;

  Future<List<Article>> _fetchPage(int pageKey) async {

    
  if (_searchQuery.isNotEmpty) {
    NewsViewModel newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
   await newsViewModel.getnewsforsearch(_searchQuery, pageKey);

      return newsViewModel.articles;

  }
  else{return[];}
 
  
}

    late final PagingController<int, Article> _pagingController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  
  
  @override
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
      print(_searchQuery);
      _pagingController.refresh();
      _currentPage = 1;
      
    });
  }


  
 
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context);

    return Scaffold(
     
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: PagingListener(
              controller: _pagingController,
            
              builder: (context, state, fetchNextPage) =>
                  PagedListView<int, Article>(
                    
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<Article>(
                  itemBuilder: (context, item, index) =>
                      NewsItem(article: item),
                      

                  // Optional indicators:

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
          ),
        ],
      ),
    );
  }
}