import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/constants.dart';
import 'package:foodistaan_restuarant/functions/order_functions.dart';
import 'package:foodistaan_restuarant/screens/home/order_picked.dart';
import 'package:foodistaan_restuarant/screens/home/order_ready.dart';
import 'package:foodistaan_restuarant/screens/home/order_widget.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _switchValue = false;
  bool _notificationVisible = true;
  bool _orderReady = false;
  bool _orderPicked = false;
  bool _orderPreparing = true;
  String readyOrders = '0', preparingOrders = '0', pickedUpOrders = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
                height: 15.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              "Outlet online",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kGreenO,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Visibility(
                            visible: _notificationVisible,
                            child: Text(
                              "Update you Restraunt Info.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kRed,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Accepting Orders",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  height: 6.h,
                                  width: 6.h,
                                  child: GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _notificationVisible =
                                            !_notificationVisible;
                                      });
                                    }),
                                    child: Card(
                                      semanticContainer: true,
                                      elevation: 0.1.h,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                      ),
                                      child: Icon(
                                        Icons.notification_important,
                                        size: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 1.h,
                                  right: 2.w,
                                  child: Container(
                                    height: 1.h,
                                    width: 1.h,
                                    decoration: BoxDecoration(
                                        color: _notificationVisible
                                            ? kGreen
                                            : kRed,
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 1.5.h),
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
                padding: EdgeInsets.only(left: 0.8.w, right: 0.8.w),
                height: 7.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: _orderPreparing ? kYellow : Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: _orderPreparing == true ? kYellow : Colors.white,
                      ),
                      width: 30.w,
                      child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          elevation: 5,
                          onPressed: () {
                            setState(() {
                              _orderReady = false;
                              _orderPicked = false;
                              _orderPreparing = true;
                            });
                          },
                          child: OrderFunctions().getCount('preparing')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: _orderReady ? kYellow : Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: _orderReady == true ? kYellow : Colors.white,
                      ),
                      width: 30.w,
                      child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          elevation: 5,
                          onPressed: () async {
                            setState(() {
                              _orderReady = true;
                              _orderPicked = false;
                              _orderPreparing = false;
                            });
                          },
                          child: OrderFunctions().getCount('ready')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: _orderPicked ? kYellow : Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: _orderPicked == true ? kYellow : Colors.white,
                      ),
                      width: 30.w,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        elevation: 5,
                        onPressed: () {
                          setState(() {
                            _orderPreparing = false;
                            _orderPicked = true;
                            _orderReady = false;
                          });
                        },
                        child: OrderFunctions().getCount('picked'),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  // padding: EdgeInsets.only(
                  //     top: 1.5.h, left: 2.5.w, right: 2.5.w, bottom: 1.5.h),
                  child: _orderPreparing
                      ? OrderFunctions().receivedOrder()
                      : _orderReady
                          ? OrderFunctions().readyOrders()
                          : OrderFunctions().pickedOrders()),
            ]))
          ],
        ),
      ),
    );
  }
}
