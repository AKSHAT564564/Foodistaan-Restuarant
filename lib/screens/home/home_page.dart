import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodistaan_restuarant/screens/home/searchOrders.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isOutletOnline = false;
  bool _notificationVisible = true;

  TabController? tabController;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  List<Widget> screens = [
    OrderFunctions().receivedOrder(),
    OrderFunctions().readyOrders(),
    OrderFunctions().pickedOrders()
  ];

  Widget tabBarWidget(category, tabValue) {
    return Container(
      width: 30.w,
      decoration: BoxDecoration(
        color: (tabController!.index == tabValue) ? kYellow : Colors.white,
        border: Border.all(
          width: 1,
          color: (tabController!.index == tabValue) ? kYellow : kGrey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        elevation: 5,
        onPressed: () {
          tabController!.index = tabValue;
          _pageController.jumpToPage(tabValue);
          setState(() {});
        },
        child: OrderFunctions().getCount(
          category,
          (tabController!.index == tabValue) ? Colors.white : kBlack,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            // shrinkWrap: true,
            children: [
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
                              value: _isOutletOnline,
                              onChanged: (bool newswitchValue) {
                                setState(() {
                                  _isOutletOnline = newswitchValue;
                                });
                              },
                            ),
                            Text(
                              _isOutletOnline
                                  ? "Outlet Online"
                                  : "Outlet Offline",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: _isOutletOnline ? kGreenO : kRed,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Visibility(
                            visible: _notificationVisible,
                            child: Text(
                              "Update your Restraunt Info.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kRed,
                              ),
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
                                      borderRadius: BorderRadius.circular(1.h),
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
                                      color:
                                          _notificationVisible ? kGreen : kRed,
                                      shape: BoxShape.circle),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // SearchOrders(
              //   "StreetFood1",
              // ),
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
                      ),
                    ),
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
                height: 8.h,
                child: TabBar(
                    // indicatorPadding: EdgeInsets.all(12),
                    controller: tabController,
                    labelColor: kYellow,
                    unselectedLabelColor: Colors.blue,
                    isScrollable: false,
                    enableFeedback: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (value) {
                      tabController!.index = value;
                    },
                    // indicator: UnderlineTabIndicator(
                    //   borderSide: BorderSide(color: kYellow, width: 1.5.sp),
                    // ),
                    indicatorColor: Colors.transparent,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Tab(
                        child: tabBarWidget('preparing', 0),
                      ),
                      Tab(child: tabBarWidget('ready', 1)),
                      Tab(child: tabBarWidget('picked', 2))
                    ]),
              ),
              Expanded(
                child: PageView(
                  children: screens,
                  controller: _pageController,
                  onPageChanged: (v) {
                    _pageController.jumpToPage(v);
                    tabController!.index = v;
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
