class Address{
  String name;
  String houseNo;
  String street;
  String city;
  String state;
  String pinCode;
  String phone;
  String email;

  Address({
    required this.name,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'houseNo': houseNo,
      'street': street,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'phone': phone,
      'email': email,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      name: map['name'] ?? '',
      houseNo: map['houseNo'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      pinCode: map['pinCode'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'houseNo': houseNo,
      'street': street,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'phone': phone,
      'email': email,
    };
  }
  //fromJson
  factory Address.fromJson(Map<String, dynamic> map) => Address.fromMap(map);

  @override
  String toString() {
    return 'Address{name: $name, houseNo: $houseNo, street: $street, city: $city, state: $state, pinCode: $pinCode, phone: $phone, email: $email}';
  }
}