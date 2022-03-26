class MenuItem {
  //Product Model

  //  {
  // "id": index,
  // "name": "Products $index",
  // "productImage":
  //     "https://cdn.pixabay.com/photo/2016/10/09/14/00/vegetable-juices-1725835_960_720.jpg",
  // "quantity": "5 x65 ml",
  // "discount-Off": 10,
  // "categorie": "package $index",
  // "price": 50.0,
  //         }

  final String id;
  final String title;
  final String cuisine;
  final String description;
  final String maxQuantity;
  final bool veg;
  final double price;
  final int discountOff;
  final String image;

  MenuItem({
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
}
