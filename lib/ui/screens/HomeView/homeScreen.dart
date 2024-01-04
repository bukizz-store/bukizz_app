
import 'dart:math';

import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/pages/student_teacher_login.3.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/ecommerce_main.dart';
import 'package:bukizz_1/ui/screens/HomeView/MySchool/main_screen.dart';
import 'package:bukizz_1/ui/screens/Signin_Screen.dart';
import 'package:bukizz_1/widgets/header_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/firebase_auth.dart';
import '../../../data/providers/header_switch.dart';

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
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);

  }

  @override
  Widget build(BuildContext context) {
    // var headerSwitchProvider = Provider.of<HeaderSwitchProvider>(context, listen: false);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
    return Scaffold(
      appBar: AppBar(

        bottom: TabBar(
          tabAlignment: TabAlignment.fill,
          labelPadding: const EdgeInsets.all(8),
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (val) {
            setState(() {
              currentTab = val;
            });
          },
          controller: _tabController,
          tabs: const [
            HeaderSwitch(text: "Ecommerce",icon: Icons.shopping_cart,),
            HeaderSwitch(text: "MySchool",icon: Icons.shopping_cart,),
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children :const [
          EcommerceMain(),
          MySchoolMain(),
        ],
      ),
    );
  }
}
