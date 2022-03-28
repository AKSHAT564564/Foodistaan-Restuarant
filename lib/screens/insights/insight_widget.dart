import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:sizer/sizer.dart';

class DeliveredOrdersInsightWidget extends StatefulWidget {
  DeliveredOrdersInsightWidget({Key? key}) : super(key: key);

  @override
  _DeliveredOrdersInsightWidgetState createState() =>
      _DeliveredOrdersInsightWidgetState();
}

class _DeliveredOrdersInsightWidgetState
    extends State<DeliveredOrdersInsightWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(
            top: 1.5.h, bottom: 1.5.h, left: 2.5.w, right: 2.5.w),
        margin: EdgeInsets.only(top: 1.5.h, left: 2.5.w, right: 2.5.w),
        decoration: BoxDecoration(
          color: kAmberLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        "3 orders",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Text(
                    "Rs.2590.12",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 1.h),
            Container(
              child: Divider(
                thickness: 3,
                color: kYellow,
              ),
            ),
            // SizedBox(height: 1.h),
            Container(
              margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
              child: Row(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This week",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Rs.7690.0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "13 orders",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 8.h,
                    child: VerticalDivider(
                      thickness: 3,
                      color: kYellow,
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This month",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Rs.17690.0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "32 orders",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RejectedOrdersInsightWidget extends StatefulWidget {
  RejectedOrdersInsightWidget({Key? key}) : super(key: key);

  @override
  _RejectedOrdersInsightWidgetState createState() =>
      _RejectedOrdersInsightWidgetState();
}

class _RejectedOrdersInsightWidgetState
    extends State<RejectedOrdersInsightWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(
            top: 1.5.h, bottom: 1.5.h, left: 2.5.w, right: 2.5.w),
        margin: EdgeInsets.only(top: 1.5.h, left: 2.5.w, right: 2.5.w),
        decoration: BoxDecoration(
          color: kAmberLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        "3 orders",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Text(
                    "Rs.259.0",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 1.h),
            Container(
              child: Divider(
                thickness: 3,
                color: kYellow,
              ),
            ),
            // SizedBox(height: 1.h),
            Container(
              margin: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
              child: Row(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This week",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Rs.690.0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "13 orders",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 8.h,
                    child: VerticalDivider(
                      thickness: 3,
                      color: kYellow,
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This month",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Rs.1690.0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "33 orders",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
