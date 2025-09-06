import 'package:flutter/material.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class Themechange extends StatelessWidget {
  const Themechange({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      margin: EdgeInsets.only(right:  8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(

          color: Provider.of<SettingsProvider>(context).isDark
              ? Colors.white
              : Colors.black,
        ),
        
       
      ),
      child: DropdownButton(
      
       
        padding: EdgeInsets.symmetric(horizontal: 8),
        underline: Container(),
      value: Provider.of<SettingsProvider>(context).themeMode == ThemeMode.light
            ? "light"
            : "dark",
            style: TextStyle(
              fontSize: 20,
              
            ),
            
        
      dropdownColor: Provider.of<SettingsProvider>(context).isDark
          ? Colors.black
          : Colors.white,
          
        items: [
        DropdownMenuItem(
      
           child: Text("Light",
            style: TextStyle(
              color: Provider.of<SettingsProvider>(context).isDark
                  ? Colors.white
                  : Colors.black,
            ),
          
          ),
          value: "light",
        ),
        DropdownMenuItem(
          child: Text("Dark",style: TextStyle(
            color: Provider.of<SettingsProvider>(context).isDark
                ? Colors.white
                : Colors.black,
          ),),
          value: "dark",
        ),
      ], onChanged: (value) {
        if (value == "light") {
          Provider.of<SettingsProvider>(context, listen: false)
              .changetheme(ThemeMode.light);
          Provider.of<SettingsProvider>(context, listen: false).saveTheme( ThemeMode.light);

        } else if (value == "dark") {
          Provider.of<SettingsProvider>(context, listen: false)
              .changetheme(ThemeMode.dark);
          Provider.of<SettingsProvider>(context, listen: false).saveTheme(ThemeMode.dark);
        }
      }),
    );
  }
}