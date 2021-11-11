import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget({Key? key}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
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
                        "ID:48444 6759",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text(
                          "6:30",
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
                              "PREPARING",
                              style: TextStyle(color: Colors.white),
                            )))),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Text(
                    "Sameer's 10th order",
                    style: TextStyle(fontSize: 10, color: Colors.teal),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("1 X Butter Special Pav Bhaji",
                      style: TextStyle(fontSize: 14)),
                  Text("3 X Garlic Naan", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child:
                    Text("Total bill : ₹299", style: TextStyle(fontSize: 14))),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: MaterialButton(
                elevation: 5,
                onPressed: null,
                child: Text(
                  "ORDER READY 01:13",
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
