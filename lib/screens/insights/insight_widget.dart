import 'package:flutter/material.dart';

class InsightWidget extends StatefulWidget {
  InsightWidget({Key? key}) : super(key: key);

  @override
  _InsightWidgetState createState() => _InsightWidgetState();
}

class _InsightWidgetState extends State<InsightWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, top: 15),
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.095,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Rs.2590.12",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Divider(
                  height: 0,
                  thickness: 3,
                  color: Colors.yellow[800],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "This week",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Rs.7690.0",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "13 orders",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: VerticalDivider(
                        width: 0,
                        thickness: 3,
                        color: Colors.yellow[800],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "This month",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Rs.17690.0",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "13 orders",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
