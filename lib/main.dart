import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/screens/home/home_page.dart';
import 'package:foodistaan_restuarant/screens/home/order_widget.dart';
import 'package:foodistaan_restuarant/screens/login/login.dart';
import 'package:foodistaan_restuarant/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    initialRoute: 'H',
    routes: {
      'SS': (context) => SplashScreen(),
      'L': (context) => LoginScreen(),
      'H': (context) => HomePage(),
      'OW': (context) => OrderWidget(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
