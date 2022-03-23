import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodistaan_restuarant/functions/order_functions.dart';
import 'package:foodistaan_restuarant/screens/home/order_picked.dart';
import 'package:foodistaan_restuarant/screens/home/order_ready.dart';
import 'package:foodistaan_restuarant/screens/home/order_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _switchValue = false;

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
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
          elevation: 5,
          onPressed: () {
            tabController!.index = tabValue;
            _pageController.jumpToPage(tabValue);
          },
          child: OrderFunctions().getCount(category)),
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
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.14,
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
                                value: _switchValue,
                                onChanged: (newSwitchValue) {
                                  setState(() {
                                    _switchValue = newSwitchValue;
                                  });
                                }),
                            Text(
                              "Outlet online",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Text(
                            "Update you Restraunt Info.",
                            style: TextStyle(
                              fontSize: 14,
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
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(
                          Icons.notification_important,
                          size: 20,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextFormField(
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
                height: MediaQuery.of(context).size.height * .08,
                child: TabBar(
                    controller: tabController,
                    labelColor: Colors.yellow,
                    unselectedLabelColor: Colors.blue,
                    isScrollable: false,
                    enableFeedback: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (value) {
                      tabController!.index = value;
                    },
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.yellow, width: 3),
                    ),
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
