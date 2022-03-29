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
  bool _isMenuOnline = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 0.5),
            color: _isMenuOnline ? null : kGreyDark2.withOpacity(0.5)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.5),
          color: _isMenuOnline ? kAmberLight : kGreyLight,
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
                      Container(
                        height: 1.h,
                        width: 1.h,
                        child: Image.asset(
                          widget.veg
                              ? 'assets/images/non-veg.png'
                              : 'assets/images/veg.png',
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: 0.8.w,
                        top: MediaQuery.of(context).size.width * 0.01),
                    child: Text(
                      "${(widget.description.length > 60) ? widget.description.substring(0, 60) + '...' : widget.description}",
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
                        SizedBox(
                          width: 1.w,
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
                                color: _isMenuOnline ? kRed : kGreyDark,
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
                value: _isMenuOnline,
                onChanged: (bool newswitchValue) {
                  setState(() {
                    _isMenuOnline = newswitchValue;
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
