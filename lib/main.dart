import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/screens/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodistaan_restuarant/screens/insights/insights.dart';
import 'package:foodistaan_restuarant/screens/login/login.dart';
import 'package:foodistaan_restuarant/screens/splash_screen.dart';
import 'package:foodistaan_restuarant/mainScreenFile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    // initialRoute: FirebaseAuth.instance.currentUser != null ? 'Main' : 'L',
    initialRoute: 'Main',
    routes: {
      'Main': (context) => MainScreenFile(),
      'SS': (context) => SplashScreen(),
      'L': (context) => LoginScreen(),
      'H': (context) => HomePage(),
      'I': (context) => Insights(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
