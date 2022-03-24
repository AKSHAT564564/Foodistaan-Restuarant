import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/constants.dart';
import 'package:foodistaan_restuarant/functions/order_functions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class OrderReadyWidget extends StatefulWidget {
  var orderData;
  OrderReadyWidget({required this.orderData});

  @override
  _OrderReadyWidgetState createState() => _OrderReadyWidgetState();
}

class _OrderReadyWidgetState extends State<OrderReadyWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1.h, bottom: 1.5.h),
      margin: EdgeInsets.only(top: 1.h, left: 2.5.w, right: 2.5.w, bottom: 1.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
            height: MediaQuery.of(context).size.height * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Id: ' + widget.orderData!['order-id'],
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text(
                        OrderFunctions().orderTime(widget.orderData!['time']),
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      ),
                      Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.h),
                    color: kGreenTag,
                  ),
                  height: 4.h,
                  child: MaterialButton(
                    elevation: 5,
                    onPressed: null,
                    child: Text(
                      widget.orderData['order-status'].toString().toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.1.h,
            color: kYellow,
          ),
          Container(
              margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.07,
              child: OrderFunctions().itemsList(widget.orderData!['items'])),
          Divider(
            thickness: 0.1.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 1.h, right: 1.h),
            alignment: Alignment.centerLeft,
            child: Text(
              "Total bill : ₹${widget.orderData['total-bill']}",
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kRed,
            ),
            child: MaterialButton(
              elevation: 5,
              onPressed: () async {
                await Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Is Order Picked Up",
                  desc: "This Will Update Order Status",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                      onPressed: () => OrderFunctions()
                          .setOrderPicked(widget.orderData!['order-id'])
                          .then((v) {
                        Navigator.pop(context);
                      }),
                      color: Color.fromRGBO(0, 179, 134, 1.0),
                    ),
                    DialogButton(
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                      onPressed: () => Navigator.pop(context),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
                return;
              },
              child: Text(
                "Is Order PickedUp?",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
