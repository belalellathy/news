
import 'package:flutter/material.dart';
import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/news/data/models/news_response/news_response.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/providers/settings_provider.dart';
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
  
int count = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    sourcesViewModel.fetchSources(widget.categoryid);
   // NewsViewModel newsModel = Provider.of<NewsViewModel>(context, listen: false);
    
    
  }

  @override
  Widget build(BuildContext context) {
    //NewsViewModel newsModel = Provider.of<NewsViewModel>(context,listen: false);
    //print(newsModel.articles.length);
    
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
             
             //newsModel.getnews(sources[selectedIndex].id!);
           // 
            
            return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorColor: Provider.of<SettingsProvider>(context).isDark?Colors.white:Colors.black,
                    dividerColor: Colors.transparent,
                    onTap: (index) {
                      if (selectedIndex != index) {
                       
                       // newsModel.getnews(sources[index].id!);
                       count=0;
    
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
                  
                  
                  builder: (context, newsModel, child) {
                      
                 
                    if (newsModel.isLoading) {

                      return Loadingindicator();
                    } else if (newsModel.errorMessage != null) {
                      return Errorindicator();
                    } else {

                     if(count==0)
                     { newsModel.getnews(sourcesViewModel.sources[selectedIndex].id!);
                     
                     count++;
                     
                     }
                       
                    
                      List<Article> articles =
                          newsModel.articles ;
                      return ListView.builder(
                        itemBuilder: (_, index) =>
                            NewsItem(article: articles[index]),
                        itemCount: articles.length,
                      );
                    } 
                  },
                )
              )
        
               ],
            ),
          );}
        },
      ),
    )
    ;
  }
}
