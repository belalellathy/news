import 'package:flutter/material.dart';
import 'package:news/home_screen.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:news/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SettingsProvider()),
  ], child:    MainApp()));
  
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (context) => HomeScreen(),
       
      },
      theme: apptheme.lightTheme,
      darkTheme: apptheme.darkTheme,
      themeMode: Provider.of<SettingsProvider>(context).themeMode // Use system theme mode
    );
  }
}
