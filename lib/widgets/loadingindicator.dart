import 'package:flutter/material.dart';

class Loadingindicator extends StatelessWidget {
  const Loadingindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
  }
}