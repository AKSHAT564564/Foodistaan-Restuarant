import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/constants.dart';
import 'package:sizer/sizer.dart';

class MenuWidget extends StatefulWidget {
  MenuWidget({
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
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 0.5),
            color: _switchValue ? null : kGreyDark2.withOpacity(0.5)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.5),
          color: _switchValue ? kAmberLight : kGreyLight,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset(
                'assets/images/${widget.image}',
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
                        "${widget.name}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
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
                    child: Text(
                      "${widget.desc}",
                      style: TextStyle(fontSize: 10.sp, color: kGreyDark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.01),
                    child: Row(
                      children: [
                        Text(
                          "₹${widget.price}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            child: Text(
                              "EDIT",
                              style: TextStyle(
                                color: _switchValue ? kRed : kGreyDark,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                              ),
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
              child: CupertinoSwitch(
                activeColor: kGreen,
                value: _switchValue,
                onChanged: (bool newswitchValue) {
                  setState(() {
                    _switchValue = newswitchValue;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
