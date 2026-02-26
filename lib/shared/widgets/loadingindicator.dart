import 'package:flutter/material.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class Loadingindicator extends StatelessWidget {
  const Loadingindicator({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Center(
      child: CircularProgressIndicator(
        color: Provider.of<SettingsProvider>(context).isDark ? Colors.white : Colors.black,
        strokeWidth: 2,
      ),
    );
  }
}