import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/model/menuItemModel.dart';
import 'package:foodistaan_restuarant/provider/menuItemsProvider.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:foodistaan_restuarant/screens/menu/addMenuItemScreen.dart';
import 'package:foodistaan_restuarant/screens/menu/editMenuItemScreen.dart';
import 'package:foodistaan_restuarant/screens/menu/menu_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _isOutletOnline = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<MenuItems>(context, listen: false);
    Provider.of<MenuItems>(context, listen: false).fetchAndSetMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    // var menuItemsProvider = Provider.of<MenuItems>(context, listen: false);
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
                      value: _isOutletOnline,
                      onChanged: (bool newswitchValue) {
                        setState(() {
                          _isOutletOnline = newswitchValue;
                        });
                      },
                    ),
                    Text(
                      _isOutletOnline ? "Outlet Online" : "Outlet Offline",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: _isOutletOnline ? kGreenO : kRed,
                      ),
                    )
                  ],
                ),
                Container(
                  child: AbsorbPointer(
                    absorbing: !_isOutletOnline,
                    child: GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.add_circle_rounded,
                            color: _isOutletOnline ? kYellow : kGrey,
                            size: 32.sp,
                          ),
                          Text(
                            "Add new Item",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: _isOutletOnline ? Colors.black : kGrey,
                            ),
                          )
                        ],
                      ),
                      onTap: (() {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //         EditMenuItemScreen(),
                        //   ),
                        // );
                        Navigator.of(context)
                            .pushNamed(AddMenuItemScreen.routeName);
                      }),
                    ),
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
                Consumer<MenuItems>(builder: (context, menuItemsProvider, _) {
                  return menuItemsProvider.menuItems.isNotEmpty
                      ? Container(
                          height: 70.h,
                          child: ListView.builder(
                              padding: EdgeInsets.only(bottom: 8.h),
                              itemCount: menuItemsProvider.menuItems.length,
                              itemBuilder: ((context, index) {
                                // print(menuItemsProvider.menuItems[index].id);
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 1.5.h, left: 2.5.w, right: 2.5.w),
                                  child: MenuWidget(
                                    id: menuItemsProvider.menuItems[index].id,
                                    title: menuItemsProvider
                                        .menuItems[index].title,
                                    cuisine: menuItemsProvider
                                        .menuItems[index].cuisine,
                                    description: menuItemsProvider
                                        .menuItems[index].description,
                                    maxQuantity: menuItemsProvider
                                        .menuItems[index].maxQuantity,
                                    veg: menuItemsProvider.menuItems[index].veg,
                                    discountOff: menuItemsProvider
                                        .menuItems[index].discountOff,
                                    price: menuItemsProvider
                                        .menuItems[index].price,
                                    image: menuItemsProvider
                                        .menuItems[index].image,
                                  ),
                                );
                              })),
                        )
                      : Center(
                          child: Container(
                            child: Text("No Category Found!"),
                          ),
                        );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
