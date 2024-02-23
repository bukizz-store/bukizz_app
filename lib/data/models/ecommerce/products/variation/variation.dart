class VariationGeneral{
  String name;
  String image;
  int price;
  int salePrice;


  VariationGeneral({required this.name, required this.price, required this.image , required this.salePrice});

  VariationGeneral.fromJson(Map<String, dynamic> json) :
        name = json['name'],
        image = json['image'],
        salePrice = json['salePrice'],
        price = json['price'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['salePrice'] = salePrice;
    data['price'] = price;
    return data;
  }

  //tomap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'salePrice': salePrice,
      'price': price,
    };
  }

  //frommap
  factory VariationGeneral.fromMap(Map<String, dynamic> map) {
    return VariationGeneral(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      salePrice: map['salePrice'] ?? '',
      price: map['price'] ?? '',
    );
  }
}