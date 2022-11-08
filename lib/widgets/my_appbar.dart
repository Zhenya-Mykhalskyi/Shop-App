import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _imageUrl =
      'https://cdn.shopify.com/s/files/1/0512/2542/8161/products/mothers-day-selection-box-exoticfruitscouk-192513_1024x1024@2x.jpg?v=1645776779';
  final String title;
  final Widget actions;
  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  const MyAppBar({Key key, this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Anton',
          color: Color.fromARGB(232, 255, 255, 255),
        ),
      ),
      actions: [actions],
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 220, 220, 220),
      ),
      flexibleSpace: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.5,
            child: Container(
              color: const Color(0xFF000000),
            ),
          ),
        ),
      ]),
    );

    // return Container(
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //         colors: <Color>[
    //           Color.fromARGB(255, 58, 217, 34),
    //           Color.fromARGB(255, 30, 227, 40),
    //           Color.fromARGB(255, 103, 226, 26),
    //         ]),
    //   ),
    // );
  }
}
