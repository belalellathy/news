
import 'package:flutter/material.dart';
import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/news/data/models/news_response/news_response.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/sources/data/models/sources_response/source.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/sources/view/widgets/tab_item.dart';
import 'package:news/sources/view_model/sources_view_model.dart';
import 'package:news/shared/widgets/errorindicator.dart';
import 'package:news/shared/widgets/loadingindicator.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key, required this.categoryid});
  final String categoryid;

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  SourcesViewModel sourcesViewModel = SourcesViewModel();
  

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    sourcesViewModel.fetchSources(widget.categoryid);

    
  }

  @override
  Widget build(BuildContext context) {
    NewsViewModel newsModel = Provider.of<NewsViewModel>(context,listen: false);
    
    return ChangeNotifierProvider(
      create: (_) => sourcesViewModel,
      child: Consumer<SourcesViewModel>(
        builder: (_, sourcesViewModel, __) {
          // Assuming you have sources list in your view model
         
          
          if(sourcesViewModel.isLoading) {
            return Loadingindicator();
          }
          else if (sourcesViewModel.error) {
            return Errorindicator();
          }
          else{
             List<Source> sources = sourcesViewModel.sources;
          
          
            newsModel.getnews(sources[selectedIndex].id!);


          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    dividerColor: Colors.transparent,
                    onTap: (index) {
                      if (selectedIndex != index) {
                         

                        setState(() {
                          selectedIndex = index;
                        });
                      }
                     
                     
                    },
                    
                    tabs: sources
                        .map(
                          (source) => TabItem(
                            source: source,
                            isSelected: selectedIndex ==
                                sources.indexOf(source),
                          ),
                        )
                        .toList(),
                
                  ),
                ),
                Expanded(
                  child: Consumer<NewsViewModel>(
                    
                    builder: (context, newsmodel, child) {
                      
                   
                      if (newsmodel.isLoading) {
                        return Loadingindicator();
                      } else if (newsmodel.errorMessage != null) {
                        return Errorindicator();
                      } else {
                        
                        List<Article> articles =
                            newsModel.articles ;
                        return ListView.builder(
                          itemBuilder: (_, index) =>
                              NewsItem(article: articles[index]),
                          itemCount: articles.length,
                        );
                      } 
                    },
                  ),
                ),
              ],
            ),
          );}
        },
      ),
    );
  }
}
