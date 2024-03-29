import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodistaan_restuarant/screens/home/order_picked.dart';
import 'package:foodistaan_restuarant/screens/home/order_ready.dart';
import 'package:foodistaan_restuarant/screens/home/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';

class OrderFunctions {
  var vendorID = FirebaseAuth.instance.currentUser!.email;
  findVendorId() {
    var splittedVendorID = vendorID!.split('@');

    return splittedVendorID[0].toLowerCase() == 'streetfood1'
        ? 'StreetFood1'
        : 'StreetFood2';
  }

  Widget receivedOrder() {
    ScrollController _controller = ScrollController();
    var stream = FirebaseFirestore.instance
        .collection('live-orders')
        .where('vendor-id', isEqualTo: 'StreetFood1')
        .where('order-status', isEqualTo: 'preparing')
        .snapshots();
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('Fetching Orders'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0)
                  return Center(
                    child: Text('No-Available Orders'),
                  );
                else {
                  return ListView.builder(
                      controller: _controller,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map orderData =
                            snapshot.data!.docs[index].data() as Map;

                        return OrderWidget(orderData: orderData);
                      });
                }
              } else
                return Center(
                  child: Text('Unkown Error'),
                );
          }
        });
  }

  orderTime(timeStamp) {
    final Timestamp timestamp = timeStamp;
    final day = timestamp.toDate().day;

    final hour = timestamp.toDate().hour.toString();
    final minutes = timestamp.toDate().minute.toString();

    return '$hour : $minutes';
  }

  Widget itemsList(Map orderItems) {
    List itemList = [];
    for (var item in orderItems.keys) {
      itemList.add(orderItems[item]);
    }

    if (itemList.length != 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (BuildContext context, int index) {
            var itemDetails = itemList[index];
            return Text(itemDetails['quantity'].toString() +
                ' X ' +
                itemDetails['name'].toString().toUpperCase());
          });
    } else
      return Text('Some Error');
  }

  acceptOrder(orderID) async {
    await FirebaseFirestore.instance
        .collection('live-orders')
        .doc(orderID)
        .update({'order-status': 'accepted-not-ready'});
  }

  setOrderReady(orderID) async {
    await FirebaseFirestore.instance
        .collection('live-orders')
        .doc(orderID)
        .update({'order-status': 'ready'});
  }

  setOrderPicked(orderID) async {
    await FirebaseFirestore.instance
        .collection('live-orders')
        .doc(orderID)
        .update({'order-status': 'picked'});
  }

  setOrderDelivery(orderID) async {
    await FirebaseFirestore.instance
        .collection('live-orders')
        .doc(orderID)
        .update({'order-status': 'delivery'});
  }

  Widget readyOrders() {
    ScrollController _controller = ScrollController();
    var stream = FirebaseFirestore.instance
        .collection('live-orders')
        .where('vendor-id', isEqualTo: 'StreetFood1')
        .where('order-status', isEqualTo: 'ready')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('Fetching Ready Orders'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0)
                  return Center(
                    child: Text('No-Ready Orders'),
                  );
                else {
                  return ListView.builder(
                      controller: _controller,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var totalReadyOrders = snapshot.data!.docs.length;
                        var orderData = snapshot.data!.docs[index].data();
                        return OrderReadyWidget(orderData: orderData);
                      });
                }
              } else {
                return Center(
                  child: Text('Unknown Error'),
                );
              }
          }
        });
  }

  Widget pickedOrders() {
    ScrollController _controller = ScrollController();
    var stream = FirebaseFirestore.instance
        .collection('live-orders')
        .where('vendor-id', isEqualTo: 'StreetFood1')
        .where('order-status', isEqualTo: 'picked')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('Fetching Ready Orders'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0)
                  return Center(
                    child: Text('No-Picked Orders'),
                  );
                else {
                  List recentOrders = [];
                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    Map<dynamic, dynamic> orderData =
                        snapshot.data!.docs[i].data() as Map<dynamic, dynamic>;

                    final last24Hours = orderData['time'].toDate().compareTo(
                        DateTime.now().subtract(Duration(hours: 24)));

                    if (last24Hours == 1) {
                      recentOrders.add(orderData);
                    } else {
                      continue;
                    }
                  }
                  if (recentOrders.isNotEmpty) {
                    return ListView.builder(
                        itemCount: recentOrders.length,
                        shrinkWrap: true,
                        controller: _controller,
                        itemBuilder: (BuildContext context, int index) {
                          return OrderPicked(orderData: recentOrders[index]);
                        });
                  } else {
                    return Center(child: Text('No orders in last 24 hours'));
                  }
                }
              } else {
                return Center(
                  child: Text('Unknown Error'),
                );
              }
          }
        });
  }

  Widget getCount(orderStatus, Color color) {
    String count = '';
    String _orderStatus = orderStatus.toString().toUpperCase();
    var stream = FirebaseFirestore.instance
        .collection('live-orders')
        .where('vendor-id', isEqualTo: 'StreetFood1')
        .where('order-status', isEqualTo: orderStatus)
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List recentOrders = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              Map<dynamic, dynamic> orderData =
                  snapshot.data!.docs[i].data() as Map<dynamic, dynamic>;

              final last24Hours = orderData['time']
                  .toDate()
                  .compareTo(DateTime.now().subtract(Duration(hours: 24)));

              if (last24Hours == 1) {
                recentOrders.add([]);
              } else {
                continue;
              }
            }
            var count = snapshot.data!.docs.length;
            return Text(
              "$_orderStatus (${recentOrders.length})",
              style: TextStyle(
                  fontSize: 12.sp, color: color, fontWeight: FontWeight.w600),
            );
          }
          return Text(
            "$_orderStatus ($count)",
            style: TextStyle(fontSize: 12.sp, color: color),
          );
        });
  }
}
