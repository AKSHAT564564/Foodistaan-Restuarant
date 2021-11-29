import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuWidgetOffline extends StatelessWidget {
  MenuWidgetOffline({
    required this.image,
    required this.name,
    required this.desc,
    required this.price,
  });

  final String image;
  final String name;
  final String desc;
  final double price;

  @override
  Widget build(BuildContext context) {
    bool _switchValue = false;
    return Material(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 0.5),
            color: Colors.grey[300]),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset(
                'assets/images/$image',
                color: Colors.grey[300],
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "$name",
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset('assets/images/veg.png'),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.01),
                    child: SafeArea(
                        child: Text(
                      "$desc",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.01),
                    child: Row(
                      children: [
                        Text(
                          "₹$price",
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            child: Text(
                              "EDIT",
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                            onTap: null,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: CupertinoSwitch(value: _switchValue, onChanged: null),
            )
          ],
        ),
      ),
    );
  }
}
