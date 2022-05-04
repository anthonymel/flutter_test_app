import 'package:flutter/material.dart';
import 'package:untitled/page/category_list_page.dart';
import 'package:untitled/page/product_list_page.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({Key? key}) : super(key: key);

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  static const List<Widget> _widgetOptions = <Widget>[
    CategoryListPage(),
    ProductListPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: Center(
        child: buildMenuContent(context, _selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Все товары',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  buildMenuContent(context, selectedIndex) {
    return _widgetOptions.elementAt(_selectedIndex);
  }
}