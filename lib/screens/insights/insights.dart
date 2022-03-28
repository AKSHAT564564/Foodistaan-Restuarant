import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:foodistaan_restuarant/screens/insights/insight_widget.dart';
import 'package:foodistaan_restuarant/mainScreenFile.dart';
import 'package:sizer/sizer.dart';

class Insights extends StatefulWidget {
  Insights({Key? key}) : super(key: key);

  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.h,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.reorder, color: Colors.black),
          ),
        ],
        title: Text(
          "Business Insights",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 1.5.h, left: 2.5.w, right: 2.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Delivered Orders",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: null,
                    child: Row(
                      children: [
                        Text(
                          "See more",
                          style: TextStyle(
                              color: kGreenO,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10.sp,
                          color: kGreenO,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: DeliveredOrdersInsightWidget(),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset('assets/images/insight_pic.png'),
          ),
          Divider(
            height: 0,
            color: Colors.grey[600],
            thickness: 5,
          ),
          Container(
            margin: EdgeInsets.only(top: 1.5.h, left: 2.5.w, right: 2.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rejected Orders",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        "Lost sales from orders rejected",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: null,
                    child: Row(
                      children: [
                        Text(
                          "See more",
                          style: TextStyle(
                              color: kGreenO,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10.sp,
                          color: kGreenO,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: RejectedOrdersInsightWidget(),
          ),
        ],
      ),
    );
  }
}
