import 'dart:convert';

class OrderQuery {
  String queryId;
  String userId;
  String query;
  String contactNo; // Change to camelCase as per Dart convention
  String queryType;
  String email;
  String orderId;
  String productName;
  String dateTime;

  OrderQuery({
    required this.queryId,
    required this.userId,
    required this.query,
    required this.contactNo,
    required this.queryType,
    required this.email,
    required this.orderId,
    required this.productName,
    required this.dateTime,
  });

  // Convert from Map to OrderQuery object
  factory OrderQuery.fromMap(Map<String, dynamic> map) {
    return OrderQuery(
      queryId: map['queryId'],
      userId: map['userId'],
      query: map['query'],
      contactNo: map['contactNo'],
      queryType: map['queryType'],
      email: map['email'],
      orderId: map['orderId'],
      productName: map['productName'],
      dateTime: map['dateTime'],
    );
  }

  // Convert from OrderQuery object to Map
  Map<String, dynamic> toMap() {
    return {
      'queryId': queryId,
      'userId': userId,
      'query': query,
      'contactNo': contactNo,
      'queryType': queryType,
      'email': email,
      'orderId': orderId,
      'productId': productName,
      'dateTime': dateTime,
    };
  }

  // Convert from JSON string to OrderQuery object
  factory OrderQuery.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return OrderQuery.fromMap(map);
  }

  // Convert from OrderQuery object to JSON string
  String toJson() {
    return jsonEncode(toMap());
  }

}
