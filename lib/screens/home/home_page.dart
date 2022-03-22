import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool _orderReady = false;
  bool _orderPicked = false;
  bool _orderPreparing = true;
  String readyOrders = '0', preparingOrders = '0', pickedUpOrders = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
            height: 12.5.h,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoSwitch(value: _switchValue, onChanged: null),
                          Text(
                            "Outlet online",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.green),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: null,
                        child: Text(
                          "Update you Restraunt Info.",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Accepting Orders",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Icon(
                        Icons.notification_important,
                        size: 18.sp,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.5.h),
            padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
            height: 8.h,
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
                          color: Colors.amber,
                          width: 2.0,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          width: 2.0,
                        )))),
          ),
          Container(
            padding: EdgeInsets.only(left: 0.8.w, right: 0.8.w),
            height: 8.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color:
                        _orderPreparing == true ? Colors.yellow : Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MaterialButton(
                      elevation: 5,
                      onPressed: () {
                        setState(() {
                          _orderReady = false;
                          _orderPicked = false;
                          _orderPreparing = true;
                        });
                      },
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: OrderFunctions().getCount('preparing'))),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: _orderReady == true ? Colors.yellow : Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MaterialButton(
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
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: _orderPicked == true ? Colors.yellow : Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MaterialButton(
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
              child: _orderPreparing
                  ? OrderFunctions().receivedOrder()
                  : _orderReady
                      ? OrderFunctions().readyOrders()
                      : OrderFunctions().pickedOrders()),
        ],
      ),
    );
  }
}
