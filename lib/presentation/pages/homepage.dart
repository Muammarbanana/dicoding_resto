import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/presentation/pages/pengaturan.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_favorit.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    RestoList(),
    RestoFavorit(),
    Pengaturan(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/heart.png'),
            ),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: kBody1,
        unselectedLabelStyle: kBody1,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
