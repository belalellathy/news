import 'package:flutter/material.dart';
import 'package:news/categories_card.dart';
import 'package:news/homedrawer.dart';
import 'package:news/models/categories_model.dart';
import 'package:news/news/view/widgets/news_view.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String id;
  late String name;
  bool taped = false;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;
    
    return SafeArea(
      child: Scaffold(
        drawer: Homedrawer(
          nothome: taped,
          onTap: () {
            taped = false;

            setState(() {});
          },
        ),

        appBar: AppBar(
          title: taped ? Text(id) : Text("Home"),
          centerTitle: true,

          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
               Navigator.of(context).pushNamed("search");
                setState(() {});
                
              },
            ),
          ],
        ),

        body: taped == true
            ? NewsView(categoryid: id,)
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 16.0 : 8.0,
                  vertical: isTablet ? 8.0 : 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning Here \nis Some News For You",
                      style: TextStyle(
                        fontSize: isLargeScreen ? 32 : isTablet ? 28 : 24,
                        fontWeight: FontWeight.w600,
                        color: settingsProvider.isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: isTablet ? 30 : 20),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: settingsProvider.isDark
                            ? (context, index) => InkWell(
                                onTap: () {
                                  
                                  id =
                                      CategoriesModel.categoriesLight[index].id;
                                  name = CategoriesModel
                                      .categoriesLight[index]
                                      .name;
                                
                                  taped = true;
                                  setState(() {});
                                },
                                child: CategoriesCard(
                                  categoriesModel:
                                      CategoriesModel.categoriesLight[index],
                                  left: (index == 1 || index == 3 || index == 6)
                                      ? 3
                                      : null,
                                  right:
                                      (index == 1 || index == 3 || index == 6)
                                      ? null
                                      : 20,
                                ),
                              )
                            : (context, index) => InkWell(
                                onTap: () {
                                  //print(CategoriesModel.categoriesDark[index].id);
                                  id = CategoriesModel.categoriesDark[index].id;
                                  name = CategoriesModel
                                      .categoriesDark[index]
                                      .name;
                                  taped = true;
                                  setState(() {});
                                  
                                },
                                child: CategoriesCard(
                                  categoriesModel:
                                      CategoriesModel.categoriesDark[index],
                                  left: (index == 1 || index == 3 || index == 6)
                                      ? 3
                                      : null,
                                  right:
                                      (index == 1 || index == 3 || index == 6)
                                      ? null
                                      : 20,
                                ),
                              ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: isTablet ? 15 : 10),
                        itemCount: 7,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
