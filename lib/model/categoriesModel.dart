import 'dart:convert';

class Categorie {
  final String id;
  final String name;
  final String categorieImage;

  Categorie({
    required this.id,
    required this.name,
    required this.categorieImage,
  });

  factory Categorie.fromJson(String str) => Categorie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categorie.fromMap(Map<String, dynamic> json) => Categorie(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        categorieImage:
            json["categorieImage"] == null ? null : json["categorieImage"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "categorieImage": categorieImage == null ? null : categorieImage,
      };
}
