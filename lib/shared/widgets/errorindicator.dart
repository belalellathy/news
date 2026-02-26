import 'package:flutter/material.dart';

class Errorindicator extends StatelessWidget {
  final String errorMessage;
  const Errorindicator({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage, style: const TextStyle(color: Colors.red),),);
  }
}