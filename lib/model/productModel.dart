class Product {
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
  final String name;
  final String categorie;
  final String quantity;
  final double price;
  final int discountOff;

  final String productImage;

  Product({
    required this.id,
    required this.name,
    required this.categorie,
    required this.quantity,
    required this.price,
    required this.discountOff,
    required this.productImage,
  });
}
