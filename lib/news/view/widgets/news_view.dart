
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news/data/models/news_response/article.dart';
import 'package:news/news/view_model/news_state.dart';

import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/sources/data/models/sources_response/source.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/sources/view/widgets/tab_item.dart';
import 'package:news/sources/view_model/sources_state.dart';
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
  NewsViewModel newsModel = NewsViewModel();
  

  int selectedIndex = 0;
 late int count;

  @override
  void initState() {
    super.initState();
    sourcesViewModel.fetchSources(widget.categoryid);
    count=0;
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (_) => sourcesViewModel,
      
      child: BlocBuilder<SourcesViewModel,SourcesState>(
        builder: (context,state) {


          if(state is SourcesLoading) {
            return Center(child: const Loadingindicator());
          }
          else if (state is SourcesFailure) {
            return  Errorindicator(errorMessage: state.error);
          }
          else{
            state= state as SourcesSuccess;
             List<Source> sources = state.sources;
             if(count==0){
               newsModel.getnews(sources[selectedIndex].id!);
              count++;
            }

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
                child: BlocProvider(
                  create: (context) => newsModel,
                  child: BlocBuilder<NewsViewModel,NewsState>(
                  
                  builder: (context,state1) {
                    if (state1 is NewsLoading) {

                      return Center(child: Loadingindicator());
                    } else if (state1 is NewsError) {
                      return Errorindicator(errorMessage: state1.message);
                    } else if(state1 is Newssucces) {
                      List<Article> articles =
                          newsModel.articles ;
                      return ListView.builder(
                        itemBuilder: (_, index) =>
                            NewsItem(article: articles[index]),
                        itemCount: articles.length,
                      );
                    } else{
                      return const SizedBox();
                    }
                  },
                  )
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
