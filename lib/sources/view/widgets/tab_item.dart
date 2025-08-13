import 'package:flutter/material.dart';
import 'package:news/sources/data/models/sources_response/source.dart';


class TabItem extends StatelessWidget {
  TabItem({super.key,  required this.isSelected, required this.source});
Source source;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return 
    
    Text(
      source.name!,
      style: isSelected
          ? TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )
          : TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
    );
  }
}
