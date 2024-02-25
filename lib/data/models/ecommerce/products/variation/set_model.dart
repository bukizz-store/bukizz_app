class SetData{
  String name;
  List<String> image;
  int sku;
  int price;
  int salePrice;

  SetData({
    required this.name,
    required this.price,
    required this.image,
    required this.salePrice,
    required this.sku,});

  SetData.fromJson(Map<String, dynamic> json) :
        name = json['name'],
        image = json['image'],
        salePrice = json['salePrice'],
        sku = json['sku'],
        price = json['price'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['sku'] = sku;
    data['salePrice'] = salePrice;
    data['price'] = price;
    return data;
  }

  //tomap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'sku': sku,
      'salePrice': salePrice,
      'price': price,
    };
  }

  //frommap
  factory SetData.fromMap(Map<String, dynamic> map) {
    return SetData(
      name: map['name'] ?? '',
      image: List<String>.from(map['image'] ?? []),
      sku: map['sku'] ?? 0,
      salePrice: map['salePrice'] ?? 0,
      price: map['price'] ?? 0,
    );
  }
}