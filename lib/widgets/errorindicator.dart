import 'package:flutter/material.dart';

class Errorindicator extends StatelessWidget {
  const Errorindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Error Occurred",style: TextStyle(color: Colors.red),),);
  }
}