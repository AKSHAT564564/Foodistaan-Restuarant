import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foodistaan_restuarant/model/categoriesModel.dart';
import 'package:foodistaan_restuarant/model/menuItemModel.dart';

import 'package:foodistaan_restuarant/model/productModel.dart';
import 'package:foodistaan_restuarant/provider/cartProvider.dart';
import 'package:foodistaan_restuarant/provider/categorieProvider.dart';
import 'package:foodistaan_restuarant/provider/menuItemsProvider.dart';

import 'package:foodistaan_restuarant/provider/productsProvider.dart';
import 'package:foodistaan_restuarant/provider/searchOrderProvider.dart';
import 'package:foodistaan_restuarant/screens/cart/cartScreen.dart';

import 'package:foodistaan_restuarant/screens/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodistaan_restuarant/screens/insights/insights.dart';
import 'package:foodistaan_restuarant/screens/login/login.dart';
import 'package:foodistaan_restuarant/screens/menu/addMenuItemScreen.dart';
import 'package:foodistaan_restuarant/screens/menu/editMenuItemScreen.dart';
import 'package:foodistaan_restuarant/screens/menu/menu.dart';

import 'package:foodistaan_restuarant/screens/splash_screen.dart';
import 'package:foodistaan_restuarant/mainScreenFile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // list of all the providers
        providers: [
          ChangeNotifierProvider<Categories>(
            create: (context) => Categories(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Products(),
          ),

          ChangeNotifierProvider(
            create: (context) => MenuItems(),
            child: Menu(),
          ),
          // ChangeNotifierProvider.value(
          //   value: SearchOrderProvider(),
          // )
        ],
        builder: (context, child) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Streato Restaurants',
              initialRoute:
                  FirebaseAuth.instance.currentUser != null ? 'Main' : 'L',
              routes: {
                'Main': (context) => MainScreenFile(),
                'SS': (context) => SplashScreen(),
                'L': (context) => LoginScreen(),
                'H': (context) => HomePage(),
                'I': (context) => Insights(),
                EditMenuItemScreen.routeName: (ctx) => EditMenuItemScreen(),
                AddMenuItemScreen.routeName: (ctx) => AddMenuItemScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
              },
            );
          });
        });
  }
}
