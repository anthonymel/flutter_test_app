import 'package:flutter/material.dart';
import 'package:untitled/navigation/bottom_navigation_menu.dart';
import 'package:untitled/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        // title: 'Products Sample',
        theme: defaultThemeData(),
        // home: const ProductListPage(),
        home: const BottomNavigationMenu(),
      );
}
