import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../models/ecommerce/product_model.dart';
import '../models/ecommerce/school_model.dart';

class SchoolDataProvider extends ChangeNotifier {
  List<SchoolModel> schoolData = [];

  String schoolName = '';
  int schoolIndex = 0;

  SchoolModel get schoolDetails => schoolData[schoolIndex];

  late SchoolModel selectedSchool;

  void setSchoolName(String name) {
    schoolName = name;
    schoolIndex = schoolData.indexWhere((element) => element.name == name);
    selectedSchool = schoolData[schoolIndex];
    notifyListeners();
  }

  //function to add temporary data to schoolData
  void addSchoolData(SchoolModel schoolModel) {
    schoolData.add(schoolModel);
    notifyListeners();
  }

  void schoolTemporaryData() {

    SchoolModel temporarySchool = SchoolModel(
      schoolId: '123',
      name: 'Dr. VSEC Awadhpuri',
      address: '123 Main Street',
      city: 'Sample City',
      state: 'Sample State',
      board: 'CBSE',
      pincode: '123456',
      contactNumber: '9876543210',
      email: 'sample@email.com',
      website: 'www.sampleschool.com',
      logo: 'sample_logo.png',
      banner: 'assets/school/vsec.jpg',
      aboutUs: 'This is a sample school for testing purposes.',
      products: [
        ProductModel(
          productId: '123',
          name: 'Class 1st',
          description: 'This is a sample product for testing purposes.',
          price: 500,
          stockQuantity: 10,
          categoryId: '123',
          image: 'sample_image.png',
          classId: '123',
          board: 'Sample Board',
          salePrice: '123.45',
        ),ProductModel(
          productId: '123',
          name: 'Class 2nd',
          description: 'This is a sample product for testing purposes.',
          price: 400,
          stockQuantity: 10,
          categoryId: '123',
          image: 'sample_image.png',
          classId: '123',
          board: 'Sample Board',
          salePrice: '123.45',
        ),ProductModel(
          productId: '123',
          name: 'Class 3rd',
          description: 'This is a sample product for testing purposes.',
          price: 300,
          stockQuantity: 10,
          categoryId: '123',
          image: 'sample_image.png',
          classId: '123',
          board: 'Sample Board',
          salePrice: '123.45',
        ),
      ],
    );

    SchoolModel temporarySchool1 = SchoolModel(
      schoolId: '123',
      name: 'Dr. VSEC Sharda Nagar',
      address: '123 Main Street',
      city: 'Sample City',
      state: 'Sample State',
      board: 'CBSE',
      pincode: '123456',
      contactNumber: '9876543210',
      email: 'sample@email.com',
      website: 'www.sampleschool.com',
      logo: 'sample_logo.png',
      banner: 'assets/school/vsec.jpg',
      aboutUs: 'This is a sample school for testing purposes.',
      products: [
        ProductModel(
          productId: '123',
          name: 'Class 1st',
          description: 'This is a sample product for testing purposes.',
          price: 450,
          stockQuantity: 10,
          categoryId: '123',
          image: 'sample_image.png',
          classId: '123',
          board: 'Sample Board',
          salePrice: '123.45',
        ),ProductModel(
          productId: '123',
          name: 'Class 2nd',
          description: 'This is a sample product for testing purposes.',
          price: 600,
          stockQuantity: 10,
          categoryId: '123',
          image: 'sample_image.png',
          classId: '123',
          board: 'Sample Board',
          salePrice: '123.45',
        ),ProductModel(
          productId: '123',
          name: 'Class 3rd',
          description: 'This is a sample product for testing purposes.',
          price: 700,
          stockQuantity: 10,
          categoryId: '123',
          image: 'sample_image.png',
          classId: '123',
          board: 'Sample Board',
          salePrice: '123.45',
        ),
      ],
    );

    addSchoolData(temporarySchool);
    addSchoolData(temporarySchool1);
    notifyListeners();
  }

}