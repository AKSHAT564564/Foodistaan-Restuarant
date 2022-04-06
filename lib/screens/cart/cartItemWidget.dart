import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/provider/cartProvider.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartItem extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final String imageUrl;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.imageUrl,
    this.quantity,
    this.title,
  );

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.5.h)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
            ),
          ],
          color: kRed,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 38.sp,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 6.w),
        margin: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 2.h,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.5.h),
            ),
            title: Text('Are you sure?'),
            titleTextStyle: TextStyle(
              fontSize: 24.sp,
              color: kRed,
            ),
            content: Text(
              'Do you want to remove the ${widget.title} of Quantity: ${widget.quantity} from the cart?',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: kGreenTag,
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: kRed,
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(widget.productId);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 2.h,
        ),
        height: 22.h,
        // width: double.infinity,
        padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.5.h)),
          boxShadow: [
            BoxShadow(
              color: kGreyOf,
              blurRadius: 6.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 15.h,
                  width: 15.h,
                  padding: EdgeInsets.all(1.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.5.h)),
                    boxShadow: [
                      BoxShadow(
                        color: kGreyOf,
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                  ),
                  // child: Image.network(
                  //   imageUrl,
                  //   fit: BoxFit.fill,
                  // ),
                ),
                SizedBox(
                  width: 1.5.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Price: ₹${(widget.price)}',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Quantity: ${(widget.quantity)}',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total: ₹${(widget.price * widget.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        color: kGreenTag,
                      ),
                      onTap: () {
                        addSingleQuantity();
                      },
                    ),
                    Container(
                      height: 5.h,
                      width: 5.h,
                      margin: EdgeInsets.only(
                        top: 1.h,
                        bottom: 1.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1.h)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          '${(widget.quantity)}',
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.remove_circle_outline_outlined,
                          color: kRed),
                      onTap: () {
                        removeSingleQuantity();
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addSingleQuantity() {
    setState(() {
      Provider.of<Cart>(context, listen: false).addItem(
          widget.productId, widget.price, widget.imageUrl, widget.title);
    });
  }

  void removeSingleQuantity() {
    setState(() {
      Provider.of<Cart>(context, listen: false)
          .removeSingleItem(widget.productId);
    });
  }
}
