import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foodistaan_restuarant/model/categoriesModel.dart';
import 'package:foodistaan_restuarant/model/menuItemModel.dart';

import 'package:foodistaan_restuarant/model/productModel.dart';
import 'package:foodistaan_restuarant/provider/categorieProvider.dart';
import 'package:foodistaan_restuarant/provider/menuItemsProvider.dart';

import 'package:foodistaan_restuarant/provider/productsProvider.dart';
import 'package:foodistaan_restuarant/provider/searchOrderProvider.dart';

import 'package:foodistaan_restuarant/screens/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodistaan_restuarant/screens/insights/insights.dart';
import 'package:foodistaan_restuarant/screens/login/login.dart';
import 'package:foodistaan_restuarant/screens/menu/addMenuItemScreen.dart';
import 'package:foodistaan_restuarant/screens/menu/editMenuItemScreen.dart';

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
          // ChangeNotifierProvider.value(
          //   value: Categories(Categories.items),
          // ),
          ChangeNotifierProvider<Categories>(
            create: (context) => Categories([
              Categorie(
                  id: "0",
                  name: "all",
                  categorieImage:
                      "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_960_720.jpg"),
              Categorie(
                  id: "1",
                  name: "packaging",
                  categorieImage:
                      "https://cdn.pixabay.com/photo/2019/08/11/16/17/carton-4399301_960_720.png"),
              Categorie(
                  id: "2",
                  name: "oil",
                  categorieImage:
                      "https://cdn.pixabay.com/photo/2013/07/13/12/33/oil-159855_960_720.png"),
              Categorie(
                  id: "3",
                  name: "ketchup",
                  categorieImage:
                      "https://cdn.pixabay.com/photo/2014/12/21/23/55/bottle-576342_960_720.png"),
              Categorie(
                  id: "4",
                  name: "milk",
                  categorieImage:
                      "https://cdn.pixabay.com/photo/2016/05/02/12/30/milk-1367171_960_720.jpg"),
              Categorie(
                  id: "5",
                  name: "bread",
                  categorieImage:
                      "https://cdn.pixabay.com/photo/2017/10/18/16/44/bread-2864703_960_720.jpg"),
            ]),
          ),
          ChangeNotifierProvider(
            create: (context) => Products([
              Product(
                id: "0",
                name: "Box Packaging",
                productImage:
                    "https://cdn.pixabay.com/photo/2016/07/12/09/31/package-1511683_960_720.jpg",
                quantity: "5 x25 pack",
                discountOff: 5,
                categorie: "packaging",
                price: 70.0,
              ),
              Product(
                id: "1",
                name: "Olive Oil",
                productImage:
                    "https://cdn.pixabay.com/photo/2014/12/21/23/59/olive-oil-576533_960_720.png",
                quantity: "4 x50 ml",
                discountOff: 18,
                categorie: "oil",
                price: 120.0,
              ),
              Product(
                id: "2",
                name: "Brown Bread",
                productImage:
                    "https://cdn.pixabay.com/photo/2018/03/21/05/24/bread-3245615_960_720.jpg",
                quantity: "5 x100 g",
                discountOff: 0,
                categorie: "bread",
                price: 150.0,
              ),
              Product(
                id: "3",
                name: "Coconut Oil",
                productImage:
                    "https://cdn.pixabay.com/photo/2017/09/28/06/50/oil-discharge-2794477_960_720.jpg",
                quantity: "3 x10 ml",
                discountOff: 10,
                categorie: "oil",
                price: 50.0,
              ),
              Product(
                id: "4",
                name: "Lactose Free Milk",
                productImage:
                    "https://cdn.pixabay.com/photo/2016/12/06/18/27/cereal-1887237_960_720.jpg",
                quantity: "2 x500 ml",
                discountOff: 15,
                categorie: "milk",
                price: 650.0,
              ),
              Product(
                id: "5",
                name: "Hot Ketchup",
                productImage:
                    "https://cdn.pixabay.com/photo/2015/01/30/08/52/ketchup-617231_960_720.jpg",
                quantity: "1 x75 ml",
                discountOff: 0,
                categorie: "ketchup",
                price: 95.0,
              ),
            ]),
          ),
          ChangeNotifierProvider<MenuItems>(
            create: (ctx) => MenuItems([
              MenuItem(
                id: "farm-house",
                title: "Farm House",
                cuisine: "pizza",
                description:
                    "A pizza that goes ballistic on veggies! Check out this mouth watering overload of crunchy, crisp capsicum, succulent mushrooms and fresh tomatoes",
                maxQuantity: "5",
                veg: false,
                discountOff: 5,
                price: 99.0,
                image: "https://www.dominos.co.in/files/items/Farmhouse.jpg",
              ),
              MenuItem(
                id: "margherita",
                title: "Margheita",
                cuisine: "pizza",
                description:
                    "A hugely popular margherita, with a deliciously tangy single cheese topping",
                maxQuantity: "5",
                veg: true,
                discountOff: 0,
                price: 99.0,
                image: "https://www.dominos.co.in/files/items/Margherit.jpg",
              )
            ]),
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
              },
            );
          });
        });
  }
}
