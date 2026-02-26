import 'package:flutter/material.dart';
import 'package:news/models/categories_model.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class CategoriesCard extends StatelessWidget {
 const CategoriesCard({
    super.key,
    required this.categoriesModel,
    this.left,
    this.right,
  });
final  CategoriesModel categoriesModel;

  final double? left;
  final double? right;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(categoriesModel.image),
        ),

        Positioned(
          bottom: 4,
          right: right,
          left: left,

          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(84),
            ),
            child: Row(
              children: [
                Text(
                  "View All",
                  style: TextStyle(
                    color: settingsProvider.isDark
                        ? Colors.white
                        : Colors.black,

                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: settingsProvider.isDark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: settingsProvider.isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
