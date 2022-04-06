import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/provider/cartProvider.dart';
import 'package:foodistaan_restuarant/screens/cart/cartScreen.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';

import 'package:foodistaan_restuarant/model/categoriesModel.dart';
import 'package:foodistaan_restuarant/model/productModel.dart';
import 'package:foodistaan_restuarant/provider/categorieProvider.dart';
import 'package:foodistaan_restuarant/provider/productsProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String selectedCategorie;
  @override
  void initState() {
    super.initState();
    Provider.of<Categories>(
      context,
      listen: false,
    ).fetchAndSetCategorieItems();
    selectedCategorie = 'all';
  }

  @override
  Widget build(BuildContext context) {
    final List<Categorie> categoriesList = Provider.of<Categories>(
      context,
      listen: false,
    ).categories;

    return SafeArea(
      child: Scaffold(
        // key: _scaffoldKey,
        // endDrawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       ListTile(
        //         minLeadingWidth: 5.w,
        //         leading: Icon(Icons.manage_accounts_rounded),
        //         title: const Text('View Profile'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         minLeadingWidth: 5.w,
        //         leading: Icon(Icons.maps_home_work_rounded),
        //         title: const Text('Address'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         minLeadingWidth: 5.w,
        //         leading: Icon(Icons.account_balance_wallet_rounded),
        //         title: const Text('Your Bank Details'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         minLeadingWidth: 5.w,
        //         leading: Icon(Icons.history),
        //         title: const Text('Your Order History'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         minLeadingWidth: 5.w,
        //         leading: Icon(Icons.calendar_today_rounded),
        //         title: const Text('Offers and Deals of the day'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         minLeadingWidth: 5.w,
        //         leading: Icon(Icons.help_rounded),
        //         title: const Text('Help'),
        //         onTap: () {},
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          toolbarHeight: 7.h,
          backgroundColor: Colors.white,
          elevation: 0,
          // leadingWidth: 8.w,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 2.5.w),
              child: GestureDetector(
                child: Icon(
                  Icons.reorder_rounded,
                  color: Colors.black,
                ),
                // onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
              ),
            ),
          ],
          title: Container(
            height: 5.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/StreatoMart.png",
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: Consumer<Cart>(builder: (_, cart, ch) {
          return cart.cartItemCount > 0
              ? GestureDetector(
                  child: Container(
                    // height: 7.h,
                    // width: 7.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: kYellow,
                        color: Colors.transparent),
                    child: Consumer<Cart>(builder: (_, cart, ch) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_rounded,
                            size: 32.sp,
                            // color: Colors.white,
                            color: kYellow,
                          ),
                          Positioned(
                              bottom: 1.h,
                              child: Text(
                                '${cart.cartItemCount}',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    // color: kYellow,
                                    color: cart.cartItemCount <= 0
                                        ? Colors.transparent
                                        : Colors.white),
                              )),
                        ],
                      );
                    }),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                )
              : Container();
        }),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: Consumer<Categories>(
                    builder: (context, categoriesProvider, child) {
                  return ListView.builder(
                      // shrinkWrap: true,
                      itemCount: categoriesProvider.categories.length,
                      // itemExtent: 100,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              selectedCategorie =
                                  categoriesProvider.categories[index].name;
                            });

                            // print(selectedCategorie);
                          },
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 2.5.h),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1.5.h),
                                  child: Container(
                                    height: 8.5.h,
                                    width: 8.5.h,
                                    decoration: BoxDecoration(
                                      color: kAmberLight,
                                      // borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image(
                                      image: NetworkImage(categoriesProvider
                                          .categories[index].categorieImage
                                          .toString()),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5,
                                ),
                                Text(
                                  '${categoriesProvider.categories[index].name}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selectedCategorie ==
                                            categoriesProvider
                                                .categories[index].name
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: selectedCategorie ==
                                            categoriesProvider
                                                .categories[index].name
                                        ? 9.sp
                                        : 8.5.sp,
                                    fontWeight: selectedCategorie ==
                                            categoriesProvider
                                                .categories[index].name
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  padding: EdgeInsets.all(0.8.h),
                  child: CategoryProductsGrid(
                      selectedCategorie: selectedCategorie)),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryProductsGrid extends StatefulWidget {
  final selectedCategorie;
  const CategoryProductsGrid({Key? key, required this.selectedCategorie})
      : super(key: key);

  @override
  State<CategoryProductsGrid> createState() => _CategoryProductsGridState();
}

class _CategoryProductsGridState extends State<CategoryProductsGrid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Products>(context, listen: false).fetchAndSetProductItems();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    var itemWidth = 40.w;
    var itemHeight = 35.h;
    return Consumer<Products>(
      builder: (context, productsProvider, child) {
        return GridView.builder(
            padding: EdgeInsets.only(bottom: 8.h),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.w,
            ),
            itemCount: widget.selectedCategorie != null
                ? productsProvider
                    .categoryItems(widget.selectedCategorie)
                    .length
                : productsProvider.products.length,
            itemBuilder: (context, index) {
              return widget.selectedCategorie != null
                  ? selectedProduct(productsProvider, cart, index)
                  : unSelectedProduct(productsProvider, cart, index);
            });
      },
    );
  }

// When default Selected Categories from Categories List
  unSelectedProduct(Products productsProvider, Cart cartProvider, int index) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 0.8.h, left: 1.w, right: 1.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.h),
                  child: Container(
                    height: 17.h,
                    width: 17.h,
                    decoration: BoxDecoration(
                      color: kAmberLight,
                      // borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      image: NetworkImage(
                          productsProvider.products[index].productImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                '${productsProvider.products[index].name}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 0.1.h,
              ),
              Text(
                productsProvider.products[index].quantity,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 8.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: Row(
                  children: [
                    productsProvider.products[index].discountOff <= 0
                        ? Text(
                            '₹${productsProvider.products[index].price}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                '₹${productsProvider.discountPriceCalculator(productsProvider.products[index].price, productsProvider.products[index].discountOff)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '₹${productsProvider.products[index].price}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 9.sp,
                                  // fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                    Spacer(),

                    Spacer(),
                    Consumer<Cart>(builder: (_, cartProvider, ch) {
                      return (cartProvider.cartSingleCount(
                                  productsProvider.products[index].id) >
                              0)
                          ? Container(
                              // padding: EdgeInsets.all(1.h),
                              margin: EdgeInsets.only(right: 1.h),
                              height: 5.h,
                              width: 17.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // color: kAmberLight,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(1.5.h),
                                // border: Border.all(width: 1.sp, color: kYellow),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: (cartProvider.cartSingleCount(
                                                productsProvider
                                                    .products[index].id) ==
                                            1)
                                        ? Icon(
                                            Icons.delete_rounded,
                                            color: kRed,
                                            size: 18.sp,
                                          )
                                        : Icon(
                                            Icons
                                                .remove_circle_outline_outlined,
                                            color: kRed,
                                            size: 18.sp,
                                          ),
                                    onTap: () {
                                      cartProvider.removeSingleItem(
                                          productsProvider.products[index].id);
                                    },
                                  ),
                                  Text(
                                      "${cartProvider.cartSingleCount(productsProvider.products[index].id)}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  InkWell(
                                    child: Icon(
                                      Icons.add_circle_outline_outlined,
                                      size: 18.sp,
                                      color: kGreenTag,
                                    ),
                                    onTap: () {
                                      cartProvider.addItem(
                                          productsProvider.products[index].id,
                                          productsProvider.products[index]
                                                      .discountOff <=
                                                  0
                                              ? productsProvider
                                                  .products[index].price
                                              : productsProvider
                                                  .discountPriceCalculator(
                                                      productsProvider
                                                          .products[index]
                                                          .price,
                                                      productsProvider
                                                          .products[index]
                                                          .discountOff),
                                          productsProvider
                                              .products[index].productImage,
                                          productsProvider
                                              .products[index].name);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white,
                                          // padding: EdgeInsets.zero,
                                          content: Text(
                                            'Added ${productsProvider.products[index].name.toUpperCase()} Of MRP: ₹${productsProvider.products[index].discountOff <= 0 ? productsProvider.products[index].price : productsProvider.discountPriceCalculator(productsProvider.products[index].price, productsProvider.products[index].discountOff)} to Cart & Quantity is ${cartProvider.cartSingleCount(productsProvider.products[index].id)}!',
                                            style: TextStyle(
                                                fontSize: 8.5.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kYellow),
                                          ),
                                          duration: Duration(seconds: 2),
                                          action: SnackBarAction(
                                            textColor: kRed,
                                            label: 'UNDO',
                                            onPressed: () {
                                              cartProvider.removeSingleItem(
                                                  productsProvider
                                                      .products[index].id);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(1.h),
                                margin: EdgeInsets.only(right: 1.h),
                                height: 5.h,
                                width: 17.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kAmberLight,
                                  borderRadius: BorderRadius.circular(1.5.h),
                                ),
                                child: Text(
                                  'ADD',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              onTap: () {
                                cartProvider.addItem(
                                    productsProvider
                                        .categoryItems(
                                            widget.selectedCategorie)[index]
                                        .id,
                                    productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .discountOff <=
                                            0
                                        ? productsProvider
                                            .categoryItems(
                                                widget.selectedCategorie)[index]
                                            .price
                                        : productsProvider.discountPriceCalculator(
                                            productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .price,
                                            productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .discountOff),
                                    productsProvider
                                        .categoryItems(
                                            widget.selectedCategorie)[index]
                                        .productImage,
                                    productsProvider
                                        .categoryItems(widget.selectedCategorie)[index]
                                        .name);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    // padding: EdgeInsets.zero,
                                    content: Text(
                                      'Added ${productsProvider.categoryItems(widget.selectedCategorie)[index].name.toUpperCase()} Of MRP: ₹${productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff <= 0 ? productsProvider.categoryItems(widget.selectedCategorie)[index].price : productsProvider.discountPriceCalculator(productsProvider.categoryItems(widget.selectedCategorie)[index].price, productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff)} to Cart & Quantity is ${cartProvider.cartSingleCount(productsProvider.categoryItems(widget.selectedCategorie)[index].id)}!',
                                      style: TextStyle(
                                          fontSize: 8.5.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kYellow),
                                    ),
                                    duration: Duration(seconds: 2),
                                    action: SnackBarAction(
                                      textColor: kRed,
                                      label: 'UNDO',
                                      onPressed: () {
                                        cartProvider.removeSingleItem(
                                            productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .id);
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                    }),

                    // GestureDetector(
                    //   child: Container(
                    //     padding: EdgeInsets.all(1.h),
                    //     margin: EdgeInsets.only(right: 1.h),
                    //     height: 5.h,
                    //     width: 15.w,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       color: kAmberLight,
                    //       borderRadius: BorderRadius.circular(1.5.h),
                    //     ),
                    //     child: Text(
                    //       'ADD',
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 10.5.sp,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     cartProvider.addItem(
                    //         productsProvider.products[index].id,
                    //         productsProvider.products[index].discountOff <= 0
                    //             ? productsProvider.products[index].price
                    //             : productsProvider.discountPriceCalculator(
                    //                 productsProvider.products[index].price,
                    //                 productsProvider
                    //                     .products[index].discountOff),
                    //         productsProvider.products[index].productImage,
                    //         productsProvider.products[index].name);
                    //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         backgroundColor: Colors.white,
                    //         content: Text(
                    //           'Added ${productsProvider.products[index].name.toUpperCase()} Of MRP: ₹${productsProvider.products[index].discountOff <= 0 ? productsProvider.products[index].price : productsProvider.discountPriceCalculator(productsProvider.products[index].price, productsProvider.products[index].discountOff)} to Cart!',
                    //           style: TextStyle(
                    //               fontSize: 8.5.sp,
                    //               fontWeight: FontWeight.w600,
                    //               color: kYellow),
                    //         ),
                    //         duration: Duration(seconds: 2),
                    //         action: SnackBarAction(
                    //           textColor: kRed,
                    //           label: 'UNDO',
                    //           onPressed: () {
                    //             cartProvider.removeSingleItem(
                    //                 productsProvider.products[index].id);
                    //           },
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 1.h,
          left: 0,
          child: productsProvider.products[index].discountOff <= 0
              ? Container()
              : Container(
                  height: 5.h,
                  width: 7.w,
                  // color: Colors.green[100],
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${productsProvider.products[index].discountOff}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

// When User Select any Categories from Categories List
  selectedProduct(Products productsProvider, Cart cartProvider, int index) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 0.8.h, left: 1.w, right: 1.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.h),
                  child: Container(
                    height: 17.h,
                    width: 17.h,
                    decoration: BoxDecoration(
                      color: kAmberLight,
                      // borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      image: NetworkImage(productsProvider
                          .categoryItems(widget.selectedCategorie)[index]
                          .productImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                '${productsProvider.categoryItems(widget.selectedCategorie)[index].name}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 0.1.h,
              ),
              Text(
                productsProvider
                    .categoryItems(widget.selectedCategorie)[index]
                    .quantity,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 8.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: Row(
                  children: [
                    productsProvider
                                .categoryItems(widget.selectedCategorie)[index]
                                .discountOff <=
                            0
                        ? Text(
                            '₹${productsProvider.categoryItems(widget.selectedCategorie)[index].price}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                '₹${productsProvider.discountPriceCalculator(productsProvider.categoryItems(widget.selectedCategorie)[index].price, productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '₹${productsProvider.categoryItems(widget.selectedCategorie)[index].price}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 9.sp,
                                  // fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                    Spacer(),
                    Consumer<Cart>(builder: (_, cartProvider, ch) {
                      return (cartProvider.cartSingleCount(productsProvider
                                  .categoryItems(
                                      widget.selectedCategorie)[index]
                                  .id) >
                              0)
                          ? Container(
                              // padding: EdgeInsets.all(1.h),
                              margin: EdgeInsets.only(right: 1.h),
                              height: 5.h,
                              width: 17.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // color: kAmberLight,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(1.5.h),
                                // border: Border.all(width: 1.sp, color: kYellow),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: (cartProvider.cartSingleCount(
                                                productsProvider
                                                    .categoryItems(
                                                        widget
                                                            .selectedCategorie)[
                                                        index]
                                                    .id) ==
                                            1)
                                        ? Icon(
                                            Icons.delete_rounded,
                                            color: kRed,
                                            size: 18.sp,
                                          )
                                        : Icon(
                                            Icons
                                                .remove_circle_outline_outlined,
                                            color: kRed,
                                            size: 18.sp,
                                          ),
                                    onTap: () {
                                      cartProvider.removeSingleItem(
                                          productsProvider
                                              .categoryItems(widget
                                                  .selectedCategorie)[index]
                                              .id);
                                      // setState(() {});
                                    },
                                  ),
                                  Text(
                                      "${cartProvider.cartSingleCount(productsProvider.categoryItems(widget.selectedCategorie)[index].id)}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  InkWell(
                                    child: Icon(
                                      Icons.add_circle_outline_outlined,
                                      size: 18.sp,
                                      color: kGreenTag,
                                    ),
                                    onTap: () {
                                      cartProvider.addItem(
                                          productsProvider
                                              .categoryItems(widget
                                                  .selectedCategorie)[index]
                                              .id,
                                          productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff <=
                                                  0
                                              ? productsProvider
                                                  .categoryItems(widget
                                                      .selectedCategorie)[index]
                                                  .price
                                              : productsProvider.discountPriceCalculator(
                                                  productsProvider
                                                      .categoryItems(widget.selectedCategorie)[
                                                          index]
                                                      .price,
                                                  productsProvider
                                                      .categoryItems(widget.selectedCategorie)[
                                                          index]
                                                      .discountOff),
                                          productsProvider
                                              .categoryItems(widget
                                                  .selectedCategorie)[index]
                                              .productImage,
                                          productsProvider
                                              .categoryItems(
                                                  widget.selectedCategorie)[index]
                                              .name);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white,
                                          // padding: EdgeInsets.zero,
                                          content: Text(
                                            'Added ${productsProvider.categoryItems(widget.selectedCategorie)[index].name.toUpperCase()} Of MRP: ₹${productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff <= 0 ? productsProvider.categoryItems(widget.selectedCategorie)[index].price : productsProvider.discountPriceCalculator(productsProvider.categoryItems(widget.selectedCategorie)[index].price, productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff)} to Cart & Quantity is ${cartProvider.cartSingleCount(productsProvider.categoryItems(widget.selectedCategorie)[index].id)}!',
                                            style: TextStyle(
                                                fontSize: 8.5.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kYellow),
                                          ),
                                          duration: Duration(seconds: 2),
                                          action: SnackBarAction(
                                            textColor: kRed,
                                            label: 'UNDO',
                                            onPressed: () {
                                              cartProvider.removeSingleItem(
                                                  productsProvider
                                                      .categoryItems(
                                                          widget
                                                              .selectedCategorie)[
                                                          index]
                                                      .id);
                                            },
                                          ),
                                        ),
                                      );
                                      // setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(1.h),
                                margin: EdgeInsets.only(right: 1.h),
                                height: 5.h,
                                width: 17.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kAmberLight,
                                  borderRadius: BorderRadius.circular(1.5.h),
                                ),
                                child: Text(
                                  'ADD',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              onTap: () {
                                cartProvider.addItem(
                                    productsProvider
                                        .categoryItems(
                                            widget.selectedCategorie)[index]
                                        .id,
                                    productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .discountOff <=
                                            0
                                        ? productsProvider
                                            .categoryItems(
                                                widget.selectedCategorie)[index]
                                            .price
                                        : productsProvider.discountPriceCalculator(
                                            productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .price,
                                            productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .discountOff),
                                    productsProvider
                                        .categoryItems(
                                            widget.selectedCategorie)[index]
                                        .productImage,
                                    productsProvider
                                        .categoryItems(widget.selectedCategorie)[index]
                                        .name);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    // padding: EdgeInsets.zero,
                                    content: Text(
                                      'Added ${productsProvider.categoryItems(widget.selectedCategorie)[index].name.toUpperCase()} Of MRP: ₹${productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff <= 0 ? productsProvider.categoryItems(widget.selectedCategorie)[index].price : productsProvider.discountPriceCalculator(productsProvider.categoryItems(widget.selectedCategorie)[index].price, productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff)} to Cart & Quantity is ${cartProvider.cartSingleCount(productsProvider.categoryItems(widget.selectedCategorie)[index].id)}!',
                                      style: TextStyle(
                                          fontSize: 8.5.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kYellow),
                                    ),
                                    duration: Duration(seconds: 2),
                                    action: SnackBarAction(
                                      textColor: kRed,
                                      label: 'UNDO',
                                      onPressed: () {
                                        cartProvider.removeSingleItem(
                                            productsProvider
                                                .categoryItems(widget
                                                    .selectedCategorie)[index]
                                                .id);
                                      },
                                    ),
                                  ),
                                );
                                // setState(() {});
                              },
                            );
                    }),
                    // Spacer(),
                    // GestureDetector(
                    //   child: Container(
                    //     padding: EdgeInsets.all(1.h),
                    //     margin: EdgeInsets.only(right: 1.h),
                    //     height: 5.h,
                    //     width: 17.w,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       color: kAmberLight,
                    //       borderRadius: BorderRadius.circular(1.5.h),
                    //     ),
                    //     child: Text(
                    //       'ADD',
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 10.5.sp,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     cartProvider.addItem(
                    //         productsProvider
                    //             .categoryItems(widget.selectedCategorie)[index]
                    //             .id,
                    //         productsProvider
                    //                     .categoryItems(
                    //                         widget.selectedCategorie)[index]
                    //                     .discountOff <=
                    //                 0
                    //             ? productsProvider
                    //                 .categoryItems(
                    //                     widget.selectedCategorie)[index]
                    //                 .price
                    //             : productsProvider.discountPriceCalculator(
                    //                 productsProvider
                    //                     .categoryItems(
                    //                         widget.selectedCategorie)[index]
                    //                     .price,
                    //                 productsProvider
                    //                     .categoryItems(
                    //                         widget.selectedCategorie)[index]
                    //                     .discountOff),
                    //         productsProvider
                    //             .categoryItems(widget.selectedCategorie)[index]
                    //             .productImage,
                    //         productsProvider
                    //             .categoryItems(widget.selectedCategorie)[index]
                    //             .name);
                    //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         backgroundColor: Colors.white,
                    //         // padding: EdgeInsets.zero,
                    //         content: Text(
                    //           'Added ${productsProvider.categoryItems(widget.selectedCategorie)[index].name.toUpperCase()} Of MRP: ₹${productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff <= 0 ? productsProvider.categoryItems(widget.selectedCategorie)[index].price : productsProvider.discountPriceCalculator(productsProvider.categoryItems(widget.selectedCategorie)[index].price, productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff)} to Cart & Quantity is ${cartProvider.cartSingleCount(productsProvider.categoryItems(widget.selectedCategorie)[index].id)}!',
                    //           style: TextStyle(
                    //               fontSize: 8.5.sp,
                    //               fontWeight: FontWeight.w600,
                    //               color: kYellow),
                    //         ),
                    //         duration: Duration(seconds: 2),
                    //         action: SnackBarAction(
                    //           textColor: kRed,
                    //           label: 'UNDO',
                    //           onPressed: () {
                    //             cartProvider.removeSingleItem(productsProvider
                    //                 .categoryItems(
                    //                     widget.selectedCategorie)[index]
                    //                 .id);
                    //           },
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 1.h,
          left: 0,
          child: productsProvider
                      .categoryItems(widget.selectedCategorie)[index]
                      .discountOff <=
                  0
              ? Container()
              : Container(
                  height: 5.h,
                  width: 7.w,
                  // color: Colors.green[100],
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${productsProvider.categoryItems(widget.selectedCategorie)[index].discountOff}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
