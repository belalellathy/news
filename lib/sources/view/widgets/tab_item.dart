import 'package:flutter/material.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/sources/data/models/sources_response/source.dart';
import 'package:provider/provider.dart';


class TabItem extends StatelessWidget {
 const TabItem({super.key,  required this.isSelected, required this.source});
  final Source source;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;
    
    return Text(
      source.name!,
      style: isSelected
          ? TextStyle(
              fontSize: isLargeScreen ? 20 : isTablet ? 18 : 16,
              fontWeight: FontWeight.w700,
              color: settingsProvider.isDark? Colors.white:Colors.black,
            )
          : TextStyle(
              fontSize: isLargeScreen ? 18 : isTablet ? 16 : 14,
              fontWeight: FontWeight.w500,
              color:settingsProvider.isDark? Colors.white:Colors.black,
            ),
    );
  }
}
