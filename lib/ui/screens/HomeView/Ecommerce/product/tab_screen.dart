import 'package:bukizz/constants/colors.dart';

import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/about_school.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/form_view.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/uniform_view.dart';
import 'package:bukizz/widgets/containers/Reusable_ColouredBox.dart';
import 'package:bukizz/widgets/custom_tab/custom_tab2.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'tab views/books_view.dart';


class TabScreen extends StatefulWidget {
  static const route = '/product_screen';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomTabBar2(
            tabController: tabController,
            onIndexChanged: (index) {
              // Handle tab index change if needed
              tabController.animateTo(index);
            },
          ),
        ),
      ),
      body: TabBarView(
        // physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          Books(),

          Forms(),

          UniformScreen(),

          AboutSchool(),
        ],
      ),
    );
  }
}




































