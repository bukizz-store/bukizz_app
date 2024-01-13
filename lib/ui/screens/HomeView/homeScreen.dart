
import 'dart:math';

import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/pages/student_teacher_login.3.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/ecommerce_main.dart';
import 'package:bukizz_1/ui/screens/HomeView/MySchool/main_screen.dart';
import 'package:bukizz_1/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz_1/widgets/header_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/firebase_auth.dart';
import '../../../data/providers/header_switch.dart';
import '../../../widgets/custom_tab/custom_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: CustomTabBar(
            onIndexChanged: (index) {
              _tabController.animateTo(index);
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          EcommerceMain(),
          MySchoolMain(),
        ],
      ),
    );
  }
}

