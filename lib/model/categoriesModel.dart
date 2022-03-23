class Categorie {
// Categories Model
//  {
//             "id": index,
//             "name": "Package $index",
//             "categorieImage":
//                 "https://cdn.pixabay.com/photo/2016/03/18/01/09/cupcake-1264214_960_720.png"
//           }
  final String id;
  final String name;
  final String categorieImage;

  Categorie({
    required this.id,
    required this.name,
    required this.categorieImage,
  });
}
