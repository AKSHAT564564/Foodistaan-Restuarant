import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/screens/home/home_page.dart';

import 'package:foodistaan_restuarant/screens/insights/insights.dart';
import 'package:foodistaan_restuarant/screens/login/login.dart';
import 'package:foodistaan_restuarant/screens/splash_screen.dart';
import 'package:foodistaan_restuarant/mainScreenFile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    initialRoute: 'Main',
    routes: {
      'Main': (context) => MainScreenFile(),
      'SS': (context) => SplashScreen(),
      'L': (context) => LoginScreen(),
      'H': (context) => HomePage(),
      // 'OW': (context) => OrderWidget(),
      'I': (context) => Insights(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
