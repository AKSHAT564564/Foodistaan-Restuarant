import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/model/categoriesModel.dart';

class Categories with ChangeNotifier {
  List<Categorie>? categorie = [
    // Categorie(
    //     id: "0",
    //     name: "all",
    //     categorieImage:
    //         "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_960_720.jpg"),
    // Categorie(
    //     id: "1",
    //     name: "packaging",
    //     categorieImage:
    //         "https://cdn.pixabay.com/photo/2019/08/11/16/17/carton-4399301_960_720.png"),
    // Categorie(
    //     id: "2",
    //     name: "oil",
    //     categorieImage:
    //         "https://cdn.pixabay.com/photo/2013/07/13/12/33/oil-159855_960_720.png"),
    // Categorie(
    //     id: "3",
    //     name: "ketchup",
    //     categorieImage:
    //         "https://cdn.pixabay.com/photo/2014/12/21/23/55/bottle-576342_960_720.png"),
    // Categorie(
    //     id: "4",
    //     name: "milk",
    //     categorieImage:
    //         "https://cdn.pixabay.com/photo/2014/12/21/23/57/milk-576439_960_720.png"),
    // Categorie(
    //     id: "5",
    //     name: "bread",
    //     categorieImage:
    //         "https://cdn.pixabay.com/photo/2017/10/18/16/44/bread-2864703_960_720.jpg"),
  ];

  Categories({this.categorie});

  List<Categorie> get categories {
    return [...categorie!];
  }

  set categories(List<Categorie> value) {
    this.categorie = value;
  }

// Fetching categorieItem from the firebase
  Future<void> fetchAndSetCategorieItems() async {
    try {
      final List<Categorie> loadedCategorieItems = [];
      final extractedData = [
        Categorie(
            id: "0",
            name: "all",
            categorieImage:
                "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_960_720.jpg"),
        Categorie(
          id: "222",
          name: "packaging",
          categorieImage:
              "https://cdn.pixabay.com/photo/2019/08/11/16/17/carton-4399301_960_720.png",
        ),
        Categorie(
          id: "333",
          name: "oil",
          categorieImage:
              "https://cdn.pixabay.com/photo/2013/07/13/12/33/oil-159855_960_720.png",
        ),
        Categorie(
            id: "444",
            name: "bread",
            categorieImage:
                "https://cdn.pixabay.com/photo/2017/10/18/16/44/bread-2864703_960_720.jpg"),
        Categorie(
          id: "555",
          name: "milk",
          categorieImage:
              "https://cdn.pixabay.com/photo/2016/05/02/12/30/milk-1367171_960_720.jpg",
        ),
        Categorie(
          id: "666",
          name: "ketchup",
          categorieImage:
              "https://cdn.pixabay.com/photo/2014/12/21/23/55/bottle-576342_960_720.png",
        )
      ];
      if (extractedData == null) {
        return;
      }
      // print(extractedData.toString());
      extractedData.forEach((element) {
        loadedCategorieItems.add(element);
      });
      categories = loadedCategorieItems;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
