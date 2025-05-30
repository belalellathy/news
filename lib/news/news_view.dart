import 'package:flutter/material.dart';
import 'package:news/models/source_model.dart';
import 'package:news/news/news_item.dart';
import 'package:news/news/tab_item.dart';

class NewsView extends StatefulWidget {
   NewsView({this.categoryid});
String? categoryid;

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<SourceModel>sources=List.generate(10, (index) => SourceModel(id: 'id$index', name: 'Source $index'));

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        DefaultTabController(
          
          length: sources.length,
          child: TabBar(
            tabAlignment: TabAlignment.start,

            isScrollable: true,
            indicatorColor: Colors.white,
            dividerColor: Colors.transparent,
            onTap: (index) {
              if(selectedIndex==index)return;
              else {
                selectedIndex = index;
                setState(() {
                  
                });
              }
              
            },
            tabs: sources.map((source)=>TabItem(source: source, isSelected: selectedIndex==sources.indexOf(source))).toList()),
        ),
        SizedBox(height: 16),
        Expanded(child: ListView.separated(
          itemBuilder: (_, index) => NewsItem(),
          separatorBuilder: (_, __) => SizedBox(height: 16),
          itemCount: 2))
      ],
    );
  }
}