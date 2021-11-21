import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodistaan_restuarant/screens/home/order_ready.dart';
import 'package:foodistaan_restuarant/screens/home/order_widget.dart';
import 'package:flutter/material.dart';

class OrderFunctions {
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
                        var orderData = snapshot.data!.docs[index].data();

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
    final hour = timestamp.toDate().hour.toString();
    final minutes = timestamp.toDate().minute.toString();

    return '$hour : $minutes';
  }

  itemsList(Map orderItems) {
    if (orderItems.length != 0) {
      return ListView.builder(
          itemCount: orderItems.length,
          itemBuilder: (BuildContext context, int index) {
            String key = orderItems.keys.elementAt(index);
            String menuItem = key.replaceAll('-', ' ').toUpperCase();
            return Text("${orderItems[key]} X $menuItem",
                style: TextStyle(fontSize: 14));
          });
    } else
      return Text('Some Eror');
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
        .where('order-status', isEqualTo: 'picked-up')
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
                  return ListView.builder(
                      controller: _controller,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
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

  Widget getCount(orderStatus) {
    String count = '';
    String _orderStatus = orderStatus.toString().toUpperCase();
    var stream = FirebaseFirestore.instance
        .collection('live-orders')
        .where('order-status', isEqualTo: orderStatus)
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var count = snapshot.data!.docs.length;
            return Text(
              "$_orderStatus ($count)",
              style: TextStyle(
                color: Colors.black,
              ),
            );
          }
          return Text(
            "$_orderStatus ($count)",
            style: TextStyle(color: Colors.black),
          );
        });
  }
}
