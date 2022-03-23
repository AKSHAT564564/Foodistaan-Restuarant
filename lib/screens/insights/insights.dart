import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/screens/insights/insight_widget.dart';
import 'package:foodistaan_restuarant/mainScreenFile.dart';

class Insights extends StatefulWidget {
  Insights({Key? key}) : super(key: key);

  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.reorder, color: Colors.black),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Business Insights",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    "Delivered Orders",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: GestureDetector(
                    onTap: null,
                    child: Text(
                      "See more ",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.22,
            child: InsightWidget(),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset('assets/images/insight_pic.png'),
          ),
          Divider(
            height: 0,
            color: Colors.grey[600],
            thickness: 5,
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            height: MediaQuery.of(context).size.height * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rejected Orders",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        "Lost sales from orders rejected",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: GestureDetector(
                    onTap: null,
                    child: Text(
                      "See more ",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.22,
            child: InsightWidget(),
          ),
        ],
      ),
    );
  }
}
