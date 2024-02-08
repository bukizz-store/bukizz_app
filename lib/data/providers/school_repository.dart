import 'dart:convert';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/providers/cart_provider.dart';
import 'package:bukizz/data/providers/stationary_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../models/ecommerce/products/product_model.dart';
import '../models/ecommerce/review_model.dart';
import 'package:provider/provider.dart';
import '../models/ecommerce/school_model.dart';

class SchoolDataProvider extends ChangeNotifier {
  List<SchoolModel> schoolData = [];

  String schoolName = '';
  int schoolIndex = 0;

  SchoolModel get schoolDetails => schoolData[schoolIndex];

  late SchoolModel selectedSchool;

  bool isSchoolDataLoaded = false;

  bool get getIsSchoolDataLoaded => isSchoolDataLoaded;

  setIsSchoolDataLoaded(bool value){
    isSchoolDataLoaded = value;
    notifyListeners();
  }

  void setSchoolName(String name , String schoolId) {
    schoolName = name;
    schoolIndex = schoolData.indexWhere((element) => element.schoolId == schoolId);
    selectedSchool = schoolData[schoolIndex];
    print(schoolIndex);
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

  void pushRandomData(){
    SchoolModel temporarySchool = SchoolModel(
      schoolId: 'SCHGDP',
      name: 'Gyan Deep Public School',
      address: 'Sector-5, Near Sheetla Mata Mandir',
      city: 'Gurugram',
      state: 'Haryana',
      board: 'CBSE',
      pincode: '122001',
      contactNumber: '1247886777',
      email: 'gyan@gmail.com',
      website: 'gyandeep.com',
      logo: 'sample_logo.png',
      banner: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/school_image%2Fschool_2.jpg?alt=media&token=65174ee6-abdf-4aa1-bc82-6cad020845f4',
      aboutUs: 'School Number 1 in Region.',
      productsId: [
        'bookset_1_1',
        'bookset_1_2',
      ],
    );

    FirebaseFirestore.instance.collection('schools').add(temporarySchool.toMap()).then((value) => {
      print('School added successfully')
    }).catchError((error) => {
      print('Failed to add school: $error')
    });
  }



  void loadData(BuildContext context) async {
  var stationaryData = Provider.of<StationaryProvider>(context, listen: false);
    await Future.delayed(Duration.zero, () {
      setIsSchoolDataLoaded(false);
    });
    stationaryData.fetchStationaryItems(context);

    AppConstants.locationSet.isNotEmpty ? await FirebaseFirestore.instance
        .collection('schools').where('city', whereIn: AppConstants.locationSet).get()
        .then((value) => schoolData = value.docs.map((e) => SchoolModel.fromMap(e.data())).toList()) : await FirebaseFirestore.instance
        .collection('schools').get()
        .then((value) => schoolData = value.docs.map((e) => SchoolModel.fromMap(e.data())).toList());

    await Future.delayed(Duration.zero, () {
      setIsSchoolDataLoaded(true);
    });
    notifyListeners();
  }

}