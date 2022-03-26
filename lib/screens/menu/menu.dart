import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/constants.dart';
import 'package:foodistaan_restuarant/screens/menu/editMenuItemScreen.dart';
import 'package:foodistaan_restuarant/screens/menu/menu_widget.dart';
import 'package:sizer/sizer.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoSwitch(
                      activeColor: kGreen,
                      value: _switchValue,
                      onChanged: (bool newswitchValue) {
                        setState(() {
                          _switchValue = newswitchValue;
                        });
                      },
                    ),
                    Text(
                      _switchValue ? "Outlet Online" : "Outlet Offline",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: _switchValue ? kGreenO : kRed,
                      ),
                    )
                  ],
                ),
                Container(
                  child: GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add_circle_rounded,
                          color: _switchValue ? kYellow : kGrey,
                          size: 32.sp,
                        ),
                        Text(
                          "Add new Item",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: _switchValue ? Colors.black : kGrey,
                          ),
                        )
                      ],
                    ),
                    onTap: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EditMenuItemScreen(),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h),
            padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
            height: 7.h,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.search),
                ),
                hintText: "Search by order ID",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: kYellow,
                      width: 2.0,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: kYellow,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "South Indian",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: MenuWidget(
                    name: "Masala Dosa",
                    image: "dosa.png",
                    desc: "Prepared freshly with some basil and Kadi Patta",
                    price: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: MenuWidget(
                    name: "Masala Dosa",
                    image: "dosa.png",
                    desc: "Prepared freshly with some basil and Kadi Patta",
                    price: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Chinese",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: MenuWidget(
                    name: "Momos",
                    image: "momos.png",
                    desc: "Prepared freshly with some basil and Kadi Patta",
                    price: 120,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: MenuWidget(
                    name: "Momos",
                    image: "momos.png",
                    desc: "Prepared freshly with some basil and Kadi Patta",
                    price: 120,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
