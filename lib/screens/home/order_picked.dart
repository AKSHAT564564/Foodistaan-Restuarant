import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/functions/order_functions.dart';

class OrderPicked extends StatefulWidget {
  final orderData;

  const OrderPicked({Key? key, required this.orderData}) : super(key: key);

  @override
  _OrderPickedState createState() => _OrderPickedState();
}

class _OrderPickedState extends State<OrderPicked> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.orderData!['order-id'],
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text(
                          OrderFunctions().orderTime(widget.orderData!['time']),
                          style: TextStyle(fontSize: 14, color: Colors.black),
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
            Row(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    color: Colors.blue,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: MaterialButton(
                            elevation: 5,
                            onPressed: null,
                            child: Text(
                              'Ready For Delivery',
                              style: TextStyle(color: Colors.white),
                            )))),
                // Container(
                //   margin: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.height * 0.02,
                //   ),
                //   child: Text(
                //     "Sameer's 10th order",
                //     style: TextStyle(fontSize: 10, color: Colors.teal),
                //   ),
                // )
              ],
            ),
            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.07,
                child: OrderFunctions().itemsList(widget.orderData!['items'])),
            Container(
                alignment: Alignment.centerLeft,
                child: Text("Total bill : ₹${widget.orderData['total-bill']}",
                    style: TextStyle(fontSize: 14))),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: MaterialButton(
                elevation: 5,
                onPressed: () async {
                  await OrderFunctions()
                      .setOrderDelivered(widget.orderData!['order-id']);
                },
                child: Text(
                  "ORDER Delivered?",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
