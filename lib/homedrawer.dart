import 'package:flutter/material.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/shared/theme.dart';
import 'package:news/shared/widgets/themechange.dart';
import 'package:provider/provider.dart';

class Homedrawer extends StatelessWidget {
  Homedrawer({super.key, required this.nothome, required this.onTap});
  bool nothome;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    
    return SizedBox(
      width: isTablet ? screenWidth * 0.35 : screenWidth * 0.75,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 16 : 8,
              vertical: isTablet ? 20 : 10,
            ),
            height: isTablet ? screenHeight * 0.12 : screenHeight * 0.145,
            decoration: BoxDecoration(
              color: settingsProvider.isDark ? apptheme.white : apptheme.black,
            ),
            child: Center(
              child: Text(
                "News App",
                style: TextStyle(
                  fontSize: isTablet ? 28 : 24,
                  fontWeight: FontWeight.w700,
                  color: settingsProvider.isDark
                      ? apptheme.black
                      : apptheme.white,
                ),
              ),
            ),
          ),
          Container(
            height: isTablet ? screenHeight * 0.78 : screenHeight * 0.745,
            decoration: BoxDecoration(
              color: settingsProvider.isDark ? apptheme.black : apptheme.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (nothome == false) {
                      Navigator.of(context).pop();
                      return;
                    } else {
                      onTap();
                      nothome = true;
                      Navigator.of(context).pop();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: settingsProvider.isDark
                            ? apptheme.white
                            : apptheme.black,
                      ),
                      SizedBox(width: isTablet ? 16 : 12),
                      Text(
                        "Go to Home",
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          color: settingsProvider.isDark
                              ? apptheme.white
                              : apptheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 15 : 10),
                Divider(
                  color: settingsProvider.isDark
                      ? apptheme.white
                      : apptheme.black,
                  thickness: isTablet ? 2 : 1,
                ),
                SizedBox(height: isTablet ? 15 : 10),
                Column(
              
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Theme",
                      style: TextStyle(
                        fontSize: isTablet ? 24 : 20,
                        fontWeight: FontWeight.bold,
                        color: settingsProvider.isDark
                            ? apptheme.white
                            : apptheme.black,
                      ),
                    ),
                    SizedBox(height: isTablet ? 15 : 10),
                    Themechange()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
