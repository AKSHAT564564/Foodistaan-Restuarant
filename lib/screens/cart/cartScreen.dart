// import 'package:Store/screens/checkout_screen.dart';
// import 'package:Store/widgets/checkout_Item.dart';
import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/provider/cartProvider.dart' show Cart;
import 'package:foodistaan_restuarant/screens/cart/cartItemWidget.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:foodistaan_restuarant/utils/customLoadingSpinner.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.h,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 8.w,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Your Cart",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 2.5.w,
              right: 1.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total :-',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Chip(
                  label: Text(
                    '₹${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: kYellow,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
                Spacer(),
                CheckoutButton(cart: cart),
                // OrderButton(cart: cart)
              ],
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: cart.cartItems.isEmpty
                ? Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        // color: Colors.blue,

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/empty_cart.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15.h,
                        child: Text(
                          'Will You Add Product In Cart ?\nYou Have Nothing In This Cart.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: kGrey,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (ctx, i) => CartItem(
                      cart.cartItems.values.toList()[i].id,
                      cart.cartItems.keys.toList()[i],
                      cart.cartItems.values.toList()[i].price,
                      cart.cartItems.values.toList()[i].imageUrl,
                      cart.cartItems.values.toList()[i].quantity,
                      cart.cartItems.values.toList()[i].title,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(primary: kYellow),
      child: _isLoading
          ? Container(height: 5.h, width: 5.h, child: CustomLoadingSpinner())
          : Text(
              'CHECKOUT NOW',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              // setState(() {
              //   _isLoading = true;
              // });
              // print(widget.cart.cartItems.values.toList().toString());
              // print(widget.cart.totalAmount);

              // setState(() {
              //   _isLoading = false;
              // });
              // widget.cart.clear();
            },
    );
  }
}
