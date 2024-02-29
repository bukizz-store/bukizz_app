class Variation{
  int price;
  int salePrice;
  int sku;
  List<String> image;
  double costPerItem;
  List<String> reviewIdList;

  Variation({
    required this.price,
    required this.salePrice,
    required this.sku,
    required this.image,
    required this.costPerItem,
    required this.reviewIdList,
  });

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'salePrice': salePrice,
      'sku': sku,
      'image': image,
      'costPerItem': costPerItem,
      'reviewIdList': reviewIdList,
    };
  }

  factory Variation.fromMap(Map<String, dynamic> map) {
    return Variation(
      price: map['price'] ?? 0,
      salePrice: map['salePrice'] ?? 0,
      sku: map['sku'] ?? 0,
      image: List<String>.from(map['image'] ?? []),
      costPerItem: map['costPerItem'] ?? 0.0,
      reviewIdList: List<String>.from(map['reviewIdList'] ?? []),
    );
  }

}