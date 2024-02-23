class SetData{
  String name;
  String price;

  SetData({required this.name, required this.price});

  SetData.fromJson(Map<String, dynamic> json) :
    name = json['name'],
    price = json['price'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }

  //tomap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  //frommap
  factory SetData.fromMap(Map<String, dynamic> map) {
    return SetData(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
    );
  }
}