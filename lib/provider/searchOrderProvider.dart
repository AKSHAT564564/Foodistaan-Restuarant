import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchOrderProvider with ChangeNotifier {
  List orderItems = [];
  Future<List> fetchOrders(vendor_id) async {
    // var orderItemsList = FirebaseFirestore.instance
    //     .collection('live-orders')
    //     .where('vendor-id', isEqualTo: 'StreetFood1')
    //     .snapshots();
    try {
      QuerySnapshot orderItemsList = await FirebaseFirestore.instance
          .collection('live-orders')
          .where('vendor-id', isEqualTo: 'StreetFood1')
          .get();

      // List orderItems = [];
      // orderItemsList.docs.forEach((doc) {
      //   print(doc["vendor-name"]);
      //   // print(orderItemsList.docs);
      //   orderItems.add(orderItemsList);
      // });
      orderItems.addAll(orderItemsList.docs);
      return orderItems;
    } catch (e) {
      print(e.toString());
    }
    print(orderItems);
    return orderItems;
  }
}
