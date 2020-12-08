import 'package:flutter/material.dart';
import 'inventory/inventory.dart';
import 'catalogue/catalogue.dart';
import 'profile/profile.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 1;
  final List<Widget> _titles = [
    Text('Catálogo'),
    Text('Inventário'),
    Text('Perfil')
  ];
  final List<Widget> _screens = [
    Catalogue(),
    Inventory(),
    Profile()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: _titles[_currentIndex],
                backgroundColor: Colors.deepPurple,
                leading: Container(),
                centerTitle: true
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.deepPurple,
              selectedItemColor: Colors.white,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: 'Catálogo'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_box_outline_blank),
                    label: 'Inventário'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Perfil'
                )
              ],
            ),
            body: _screens[_currentIndex],
          )
        )
      )
    );
  }
}