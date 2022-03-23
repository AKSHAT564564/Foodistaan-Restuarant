import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/functions/order_functions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8),
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
                        'Id: ' + widget.orderData!['order-id'],
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
                              widget.orderData['order-status']
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            )))),
              ],
            ),
            Container(
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
                  await Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "RFLUTTER ALERT",
                    desc: "Flutter is more awesome with RFlutter Alert.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                          "GRADIENT",
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                  "ORDER PickedUp?",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
