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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: MediaQuery.of(context).size.height * 0.145,
            decoration: BoxDecoration(
              color: settingsProvider.isDark ? apptheme.white : apptheme.black,
            ),
            child: Center(
              child: Text(
                "News App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: settingsProvider.isDark
                      ? apptheme.black
                      : apptheme.white,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.745,
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
                      SizedBox(width: 12),
                      Text(
                        "Go to Home",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: settingsProvider.isDark
                              ? apptheme.white
                              : apptheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: settingsProvider.isDark
                      ? apptheme.white
                      : apptheme.black,
                ),
                SizedBox(height: 10),
                Column(
              
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Theme",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: settingsProvider.isDark
                            ? apptheme.white
                            : apptheme.black,
                      ),
                    ),
                    SizedBox(height: 10),
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
