import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/common/constants.dart';
import 'package:flutter_resto_dicoding/data/helper/notification_helper.dart';
import 'package:flutter_resto_dicoding/data/provider/scheduling_provider.dart';
import 'package:flutter_resto_dicoding/presentation/pages/pengaturan.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_detail.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_favorit.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const RestoList(),
    const RestoFavorit(),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: const Pengaturan(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestoDetail.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
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
