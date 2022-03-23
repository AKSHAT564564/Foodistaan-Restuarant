import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/screens/home/home_page.dart';
import 'package:foodistaan_restuarant/screens/insights/insights.dart';
import 'package:foodistaan_restuarant/screens/menu/menu.dart';
import 'package:foodistaan_restuarant/screens/offers/offer.dart';
import 'package:foodistaan_restuarant/screens/payments/payment.dart';

class MainScreenFile extends StatefulWidget {
  MainScreenFile({Key? key}) : super(key: key);

  @override
  _mainScreenFileState createState() => _mainScreenFileState();
}

class _mainScreenFileState extends State<MainScreenFile> {
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  int currentIndex = 0;

  static List<Widget> myScreens = <Widget>[
    HomePage(),
    Insights(),
    Payment(),
    Offer(),
    Menu(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: myScreens.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xff0E1829),
        selectedItemColor: Color(0xffFAC05E),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money_off,
            ),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.disc_full_outlined,
            ),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank,
            ),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
