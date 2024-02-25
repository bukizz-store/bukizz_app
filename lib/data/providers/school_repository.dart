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
      schoolId: 'SCHSHI',
      name: 'Shalom Hills International School',
      address: 'Sushant Lok Phase 1',
      city: 'Gurugram',
      state: 'Haryana',
      board: 'CBSE',
      pincode: '122002',
      contactNumber: '01244046471',
      email: 'feedback@shalomhills.com',
      website: 'www.shalomhills.com',
      logo: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/school_image%2FShalom%20Hills%2FShalom_Logo.png?alt=media&token=e4cd3806-64f0-45c8-b12e-1d523a0e9bbb',
      banner: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/school_image%2FShalom%20Hills%2FShalom_Banner.png?alt=media&token=5e48daa3-3414-45fb-ad0f-bfc3a57da365',
      aboutUs: 'In today\'s fast changing and rapidly evolving world, the lowered attention span and threshold of students has become a key problem area for parents and educationists. Thus, it is imperative that education is innovative and at the same time, stimulates and retains the interest of students. Shalom Hills International School has accepted the challenge to be constantly creative, to employ the latest IT tools and to embrace innovative learning facilities that will enhance and enrich the educational process and also enthuse and empower the students. Shalom Hills International School provides 360 degree new age digital education and thus, is the school that lives up to its motto, Your Aspirations, Our Commitments.',
      mission: 'To create a caring environment with a stimulating and comprehensive program to foster, nurture and secure the socio-emotional, physical, intellectual, spiritual development of each child and endowing them with patriotic feelings and civic-minded spirit.',
      productsId: [
        'BSCL1',
        'BSCL2',
        'BSCL3',
        'BSCL4',
        'BSCL5',
        'BSCL6',
        'BSCL7',
        'BSCL8',
        'BSCL9',
        'BSCL10',
        'BSCL11',
        'BSCL12',
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
      schoolId: 'SCHSHI',
      name: 'Shalom Hills International School',
      address: 'Sushant Lok Phase 1',
      city: 'Gurugram',
      state: 'Haryana',
      board: 'CBSE',
      pincode: '122002',
      contactNumber: '01244046471',
      email: 'feedback@shalomhills.com',
      website: 'www.shalomhills.com',
      logo: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/school_image%2FShalom%20Hills%2FShalom_Logo.png?alt=media&token=e4cd3806-64f0-45c8-b12e-1d523a0e9bbb',
      banner: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/school_image%2FShalom%20Hills%2FShalom_Banner.png?alt=media&token=5e48daa3-3414-45fb-ad0f-bfc3a57da365',
      aboutUs: 'In today\'s fast changing and rapidly evolving world, the lowered attention span and threshold of students has become a key problem area for parents and educationists. Thus, it is imperative that education is innovative and at the same time, stimulates and retains the interest of students. Shalom Hills International School has accepted the challenge to be constantly creative, to employ the latest IT tools and to embrace innovative learning facilities that will enhance and enrich the educational process and also enthuse and empower the students. Shalom Hills International School provides 360 degree new age digital education and thus, is the school that lives up to its motto, Your Aspirations, Our Commitments.',
      mission: 'To create a caring environment with a stimulating and comprehensive program to foster, nurture and secure the socio-emotional, physical, intellectual, spiritual development of each child and endowing them with patriotic feelings and civic-minded spirit.',
      productsId: [
        'BSCL1',
        'BSCL2',
        'BSCL3',
        'BSCL4',
        'BSCL5',
        'BSCL6',
        'BSCL7',
        'BSCL8',
        'BSCL9',
        'BSCL10',
        'BSCL11',
        'BSCL12',
      ],
    );

    FirebaseFirestore.instance.collection('schools').add(temporarySchool.toMap()).then((value) => {
      print('School added successfully')
    }).catchError((error) => {
      print('Failed to add school: $error')
    });
  }



  Future loadData(BuildContext context) async {
  var stationaryData = Provider.of<StationaryProvider>(context, listen: false);
    await Future.delayed(Duration.zero, () {
      setIsSchoolDataLoaded(false);
    });
    stationaryData.fetchStationaryItems(context);

    AppConstants.location != '' ? await FirebaseFirestore.instance
        .collection('schools').where('city', isEqualTo: AppConstants.location).get()
        .then((value) => schoolData = value.docs.map((e) => SchoolModel.fromMap(e.data())).toList()) : await FirebaseFirestore.instance
        .collection('schools').get()
        .then((value) => schoolData = value.docs.map((e) => SchoolModel.fromMap(e.data())).toList());

    await Future.delayed(Duration.zero, () {
      setIsSchoolDataLoaded(true);
    });
    notifyListeners();
  }

}