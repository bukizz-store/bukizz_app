
import 'dart:math';

import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/pages/student_teacher_login.3.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/ecommerce_main.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/MySchool/main_screen.dart';
import 'package:bukizz_1/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz_1/widgets/header_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/firebase_auth.dart';
import '../../../data/providers/cart_provider.dart';
import '../../../data/providers/header_switch.dart';
import '../../../data/providers/school_repository.dart';
import '../../../widgets/custom_tab/custom_tab1.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(38.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: CustomTabBar(
              onIndexChanged: (index) {
                _tabController.animateTo(index);
              },
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(), // Disable swiping
        children: const [
          MainScreen(),
          MySchoolMain(),
        ],
      ),
    );
  }
}
