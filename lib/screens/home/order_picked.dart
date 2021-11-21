import 'package:flutter/material.dart';

class OrderPicked extends StatefulWidget {
  const OrderPicked({Key? key}) : super(key: key);

  @override
  _OrderPickedState createState() => _OrderPickedState();
}

class _OrderPickedState extends State<OrderPicked> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Order Picked'),
    );
  }
}
