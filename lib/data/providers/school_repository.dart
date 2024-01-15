import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../models/ecommerce/product_model.dart';
import '../models/ecommerce/review_model.dart';
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
      productsId: [
        'bookset_1_1',
        'bookset_1_2',
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
      productsId: [
        'bookset_1_1',
        'bookset_1_2',
      ],
    );

    addSchoolData(temporarySchool);
    addSchoolData(temporarySchool1);
    notifyListeners();
  }

}