import 'package:flutter/material.dart';
import 'package:news/API/api_service.dart';
import 'package:news/models/news_response/article.dart';
import 'package:news/models/news_response/news_response.dart';
import 'package:news/models/sources_response/source.dart';
import 'package:news/models/sources_response/sources_response.dart';
import 'package:news/news/news_item.dart';
import 'package:news/news/tab_item.dart';
import 'package:news/widgets/errorindicator.dart';
import 'package:news/widgets/loadingindicator.dart';

class NewsView extends StatefulWidget {
  NewsView({super.key, required this.categoryid});
  String categoryid;

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late Future<SourcesResponse> sourcesFuture = ApiService.getsources(widget.categoryid);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
       future:sourcesFuture ,builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
           return Loadingindicator();
          }else if(snapshot.hasError||snapshot.data?.status!="ok"){
            return Errorindicator();
          }else{
            List<Source>sources = snapshot.data?.sources??[];
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                
                      
                      children: [
                       
                        DefaultTabController(
              length:sources.length,
              
              child: TabBar(
                tabAlignment: TabAlignment.start,
                    
                isScrollable: true,
                indicatorColor: Colors.white,
                dividerColor: Colors.transparent,
                onTap: (index) {
                  if (selectedIndex == index) {
                    return;
                  } else {
                    selectedIndex = index;
                    setState(() {});
                  }
                },
                tabs: sources.map(
                  (source)=> TabItem(
                  source: source,
                  isSelected: selectedIndex==sources.indexOf(source),)
                ).toList()
              ),
                        ),
                        
                        Expanded(
              child: FutureBuilder<NewsResponse>(
                future: ApiService.getnews(sources[selectedIndex].id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loadingindicator();
                  } else if (snapshot.hasError || snapshot.data?.status !="ok" ) {
                    
                    return Errorindicator();
                  } else {
                    List<Article> articles = snapshot.data?.articles ?? [];
                    return ListView.separated(
                      itemBuilder: (_, index) => NewsItem(article: articles[index]),
                      separatorBuilder: (_, __) => SizedBox(height: 16),
                      itemCount: articles.length,
                    );
                  }
                },
              ),
                        ),
                      ],
                    ),
            );
          }
       }
    );
  }
}
            
