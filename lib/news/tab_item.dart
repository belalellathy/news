import 'package:flutter/material.dart';
import 'package:news/models/source_model.dart';

class TabItem extends StatelessWidget {
   TabItem({required this.source,required this.isSelected});
SourceModel source;
bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Text(source.name,
      style: isSelected? TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ):TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,

      )
    );
  }
}