import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:foodistaan_restuarant/functions/order_functions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class OrderPicked extends StatefulWidget {
  var orderData;
  OrderPicked({required this.orderData});

  @override
  _OrderPickedState createState() => _OrderPickedState();
}

class _OrderPickedState extends State<OrderPicked> {
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
                      'Id: ' + widget.orderData['order-id'],
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text(
                        OrderFunctions().orderTime(widget.orderData['time']),
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
                      widget.orderData!['order-status']
                          .toString()
                          .toUpperCase(),
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
            child: OrderFunctions().itemsList(widget.orderData['items']),
          ),
          Divider(
            thickness: 0.1.h,
          ),
          Container(
              margin: EdgeInsets.only(left: 1.h, right: 1.h),
              alignment: Alignment.centerLeft,
              child: Text("Total bill : ₹${widget.orderData['total-bill']}",
                  style: TextStyle(fontSize: 12.sp))),
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
                await showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    alignment: Alignment.center,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
                    insetPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15,
                      vertical: MediaQuery.of(context).size.height * 0.3,
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 40.sp,
                          color: kGreenTag,
                        ),
                        Text(
                          'Is Order Picked ?',
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                    content: Text(
                      'This Will Update Order Status',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                    actions: <Widget>[
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: kGreenTag,
                          ),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () async {
                          await OrderFunctions()
                              .setOrderDelivery(widget.orderData!['order-id'])
                              .then((v) {
                            Navigator.of(ctx).pop(true);
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(116, 116, 191, 1.0),
                              Color.fromRGBO(52, 138, 199, 1.0)
                            ]),
                          ),
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop(false);
                        },
                      ),
                    ],
                  ),
                );
                // await Alert(
                //   context: context,
                //   type: AlertType.warning,
                //   title: "Is Order Picked",
                //   desc: "This Will Update Order Status",
                //   buttons: [
                //     DialogButton(
                //       child: Text(
                //         "Yes",
                //         style: TextStyle(color: Colors.white, fontSize: 18.sp),
                //       ),
                // onPressed: () => OrderFunctions()
                //     .setOrderReady(widget.orderData!['order-id'])
                //     .then((v) {
                //   Navigator.pop(context);
                // }),
                //       color: Color.fromRGBO(0, 179, 134, 1.0),
                //     ),
                //     DialogButton(
                //       child: Text(
                //         "No",
                //         style: TextStyle(color: Colors.white, fontSize: 18.sp),
                //       ),
                //       onPressed: () => Navigator.pop(context),
                //       gradient: LinearGradient(colors: [
                //         Color.fromRGBO(116, 116, 191, 1.0),
                //         Color.fromRGBO(52, 138, 199, 1.0)
                //       ]),
                //     )
                //   ],
                // ).show();
                // return;
              },
              child: Text(
                "Is Order Picked?",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
