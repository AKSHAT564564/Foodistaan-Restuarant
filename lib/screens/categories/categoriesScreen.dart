import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/constants.dart';

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
  late String selectedCategorie;
  @override
  void initState() {
    super.initState();
    selectedCategorie = 'all';
  }

  @override
  Widget build(BuildContext context) {
    final List<Categorie> categoriesList = Provider.of<Categories>(
      context,
      listen: false,
    ).items;

    return SafeArea(
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(5),
                // color: Colors.red,
                child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: categoriesList.length,
                    // itemExtent: 100,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategorie = categoriesList[index].name;
                          });
                          // productsProvider.categoryItems(selectedCategorie);
                          print(selectedCategorie);
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
                                    image: NetworkImage(categoriesList[index]
                                        .categorieImage
                                        .toString()),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.5,
                              ),
                              Text(
                                '${categoriesList[index].name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedCategorie ==
                                          categoriesList[index].name
                                      ? Colors.black
                                      : Colors.grey,
                                  fontSize: selectedCategorie ==
                                          categoriesList[index].name
                                      ? 9.sp
                                      : 8.5.sp,
                                  fontWeight: selectedCategorie ==
                                          categoriesList[index].name
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
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
  Widget build(BuildContext context) {
    var itemWidth = 40.w;
    var itemHeight = 35.h;
    return Consumer<Products>(
      builder: (context, products, child) {
        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.w,
            ),
            itemCount: widget.selectedCategorie != null
                ? products.categoryItems(widget.selectedCategorie).length
                : products.items.length,
            itemBuilder: (context, index) {
              return widget.selectedCategorie != null
                  ? selectedProduct(products, index)
                  : unSelectedProduct(products, index);
            });
      },
    );
  }

// When default Selected Categories from Categories List
  unSelectedProduct(Products products, int index) {
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
                      image: NetworkImage(products.items[index].productImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                '${products.items[index].name}',
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
                products.items[index].quantity,
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
                    products.items[index].discountOff <= 0
                        ? Text(
                            '₹${products.items[index].price}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                '₹${products.discountPriceCalculator(products.items[index].price, products.items[index].discountOff)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '₹${products.items[index].price}',
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
                    Container(
                      padding: EdgeInsets.all(1.h),
                      margin: EdgeInsets.only(right: 1.h),
                      height: 5.h,
                      width: 15.w,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 1.h,
          left: 0,
          child: products.items[index].discountOff <= 0
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
                        '${products.items[index].discountOff}%',
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
  selectedProduct(Products products, int index) {
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
                      image: NetworkImage(products
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
                '${products.categoryItems(widget.selectedCategorie)[index].name}',
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
                products
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
                    products
                                .categoryItems(widget.selectedCategorie)[index]
                                .discountOff <=
                            0
                        ? Text(
                            '₹${products.categoryItems(widget.selectedCategorie)[index].price}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                '₹${products.discountPriceCalculator(products.categoryItems(widget.selectedCategorie)[index].price, products.categoryItems(widget.selectedCategorie)[index].discountOff)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '₹${products.categoryItems(widget.selectedCategorie)[index].price}',
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
                    Container(
                      padding: EdgeInsets.all(1.h),
                      margin: EdgeInsets.only(right: 1.h),
                      height: 5.h,
                      width: 15.w,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 1.h,
          left: 0,
          child: products
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
                        '${products.categoryItems(widget.selectedCategorie)[index].discountOff}%',
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
