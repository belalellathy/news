import 'package:flutter/material.dart';
import 'package:news/models/categories_model.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategoriesCard extends StatelessWidget {
   CategoriesCard({required this.categoriesModel,this.left, this.right});
CategoriesModel categoriesModel;

double?left=null;
double?right=null;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            categoriesModel
            .image,
            
          ),
        ),
        
        Positioned(
       bottom: 4,
          right: right,
          left: left,
          
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(84),
            ),
            child: Row(
              
              children: [
                
                Text("View All",
                  style: TextStyle(
                    color: settingsProvider.isDark ? Colors.white : Colors.black,
                   
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: settingsProvider.isDark? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.arrow_forward_ios,
                    color: settingsProvider.isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
}