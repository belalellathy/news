import 'package:flutter/material.dart';
import 'package:news/home_screen.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/shared/theme.dart';
import 'package:news/news/view/widgets/search_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
        
      ),
      ChangeNotifierProvider(create: (_) => NewsViewModel())
    ],
    child: const MainApp()
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   SettingsProvider settingsProvider= Provider.of<SettingsProvider>(context, listen: false);
 settingsProvider.loadTheme();
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "home",
        routes: {
        "home": (context) => HomeScreen(),
        "search": (context) => SearchView(),
        },
        theme: apptheme.lightTheme,
        darkTheme: apptheme.darkTheme,
        themeMode: Provider.of<SettingsProvider>(
          context,
        ).themeMode, 
      ),
    );
  }
}
