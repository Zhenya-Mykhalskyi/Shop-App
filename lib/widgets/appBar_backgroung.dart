import 'package:flutter/material.dart';

class AppBarBackground extends StatelessWidget {
  const AppBarBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color.fromARGB(255, 58, 217, 34),
              Color.fromARGB(255, 30, 227, 40),
              Color.fromARGB(255, 226, 206, 26),
            ]),
      ),
    );
  }
}
