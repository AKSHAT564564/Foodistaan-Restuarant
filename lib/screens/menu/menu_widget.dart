import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:foodistaan_restuarant/screens/menu/editMenuItemScreen.dart';
import 'package:sizer/sizer.dart';

class MenuWidget extends StatefulWidget {
  final String id;
  final String title;
  final String cuisine;
  final String description;
  final String maxQuantity;
  final bool veg;
  final double price;
  final int discountOff;
  final String image;

  MenuWidget({
    required this.id,
    required this.title,
    required this.cuisine,
    required this.description,
    required this.maxQuantity,
    required this.veg,
    required this.price,
    required this.discountOff,
    required this.image,
  });

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
              // child: Image.asset(
              //   'assets/images/${widget.image}',
              //   fit: BoxFit.fill,
              // ),
              child: Image.network('${widget.image}', fit: BoxFit.fill),
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
                        "${widget.title}",
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
                      "${widget.description}",
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
                        GestureDetector(
                          onTap: (() {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         EditMenuItemScreen(),
                            //   ),
                            // );
                            Navigator.of(context).pushNamed(
                                EditMenuItemScreen.routeName,
                                arguments: widget.id);
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "EDIT",
                              style: TextStyle(
                                color: _switchValue ? kRed : kGreyDark,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
