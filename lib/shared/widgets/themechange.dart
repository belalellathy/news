import 'package:flutter/material.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class Themechange extends StatelessWidget {
  const Themechange({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: settingsProvider.isDark ? Colors.white : Colors.black,
        ),
      ),
      child: DropdownButton(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        underline: Container(),
        value: settingsProvider.themeMode == ThemeMode.light
            ? "light"
            : settingsProvider.themeMode == ThemeMode.dark
                ? "dark"
                : "system", // 👈 add system
        style: const TextStyle(fontSize: 20),
        dropdownColor:
            settingsProvider.isDark ? Colors.black : Colors.white,
        items: [
          DropdownMenuItem(
            value: "light",
            child: Text(
              "Light",
              style: TextStyle(
                color: settingsProvider.isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "dark",
            child: Text(
              "Dark",
              style: TextStyle(
                color: settingsProvider.isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "system",
            child: Text(
              "System",
              style: TextStyle(
                color: settingsProvider.isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
        onChanged: (value) {
          if (value == "light") {
            settingsProvider.changetheme(ThemeMode.light);
            settingsProvider.saveTheme(ThemeMode.light);
          } else if (value == "dark") {
            settingsProvider.changetheme(ThemeMode.dark);
            settingsProvider.saveTheme(ThemeMode.dark);
          } else if (value == "system") {
            settingsProvider.changetheme(ThemeMode.system);
            settingsProvider.saveTheme(ThemeMode.system);
          }
        },
      ),
    );
  }
}
