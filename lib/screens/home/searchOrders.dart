import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:foodistaan_restuarant/utils/customLoadingSpinner.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<List> fetchOrders(vendor_id) async {
  List orderItems = [];
  var orderItemsList = FirebaseFirestore.instance
      .collection('live-orders')
      .where('vendor-id', isEqualTo: 'StreetFood1')
      .snapshots();
  try {
    print(orderItemsList);
    await orderItemsList.forEach((element) {
      orderItems.add(element.docs);
    });
  } catch (e) {
    print(e.toString());
  }
  print(orderItems);
  return orderItems;
}

class SearchOrders extends StatefulWidget {
  final vendorId;

  SearchOrders(this.vendorId);

  @override
  State<SearchOrders> createState() => _SearchOrdersState();
}

class _SearchOrdersState extends State<SearchOrders> {
  List orderItems = [];

  final _searchController = TextEditingController();

  ValueNotifier<List> searchResults = ValueNotifier([]);

  searchQuery(String query, List items) {
    List searchResultsTemp = [];
    for (var item in items) {
      RegExp regExp = new RegExp(query, caseSensitive: false);
      bool containe = regExp.hasMatch(item['search']);
      if (containe) {
        searchResultsTemp.add(item);
      }
    }
    searchResults.value = searchResultsTemp;
  }

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.45;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white60,
          ),
          height: h1 * 0.055,
          width: w1 * 1,
          child: TextFormField(
            controller: _searchController,
            onChanged: (v) async {
              searchQuery(_searchController.text, orderItems);
              setState(() {}); //for cross icon in searchbar
            },
            textAlign: TextAlign.start,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 8,
                ),
                hintText: 'Search by Order ID',
                hintStyle: TextStyle(
                  color: kGreyDark,
                  fontSize: 15,
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 1.5,
                      bottom: 1.5,
                      left: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFAB84C),
                      shape: BoxShape.circle,
                    ),
                    child: _searchController.text.isNotEmpty
                        ? InkWell(
                            child: Icon(
                              Icons.clear_rounded,
                              color: Colors.white,
                            ),
                            onTap: () {
                              _searchController.text = '';
                              searchResults.value = [];
                              setState(() {}); //for cross icon in searchbar
                            },
                          )
                        : Icon(
                            Icons.search,
                            // size: 22,
                            // color: kGrey,
                            color: Colors.white,
                          ),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFFFAB84C),
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    // color: Color(0xFFFAB84C),
                    color: Colors.transparent,
                    width: 1,
                  ),
                )),
          ),
        ),
        SizedBox(
          height: 2.5.h,
        ),
        ValueListenableBuilder<List>(
            valueListenable: searchResults,
            builder: (_, value, __) {
              return value.isNotEmpty && _searchController.text.isNotEmpty
                  ? SearchOrderItemList(
                      searchResults: value,
                    )
                  : (orderItems.isEmpty)
                      ? Container(
                          // height: 30.h,
                          child: Center(
                            child: CustomLoadingSpinner(),
                          ),
                        )
                      : GridView.count(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisSpacing: 5,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          children: List.generate(orderItems.length, (index) {
                            return Container();
                          }),
                        );
            })
      ],
    );
  }
}

class SearchOrderItemList extends StatefulWidget {
  const SearchOrderItemList({Key? key, required searchResults})
      : super(key: key);

  @override
  _SearchOrderItemListState createState() => _SearchOrderItemListState();
}

class _SearchOrderItemListState extends State<SearchOrderItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
    );
  }
}
