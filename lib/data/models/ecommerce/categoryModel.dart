
class CategoryModel {
  String categoryId;
  String name;
  String image;
  String description;
  String offers;

  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.image,
    required this.description,
    required this.offers,
  });

  //fromMap
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      offers: map['offers'] ?? '',
    );
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'image': image,
      'description': description,
      'offers': offers,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryId: json["categoryId"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    offers: json["offers"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "name": name,
    "image": image,
    "description": description,
    "offers": offers,
  };
}