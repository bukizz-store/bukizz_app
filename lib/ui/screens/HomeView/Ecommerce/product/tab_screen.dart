import 'package:bukizz/constants/colors.dart';

import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/about_school.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/form_view.dart';
import 'package:bukizz/widgets/containers/Reusable_ColouredBox.dart';
import 'package:bukizz/widgets/custom_tab/custom_tab2.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/product_provider.dart';
import '../../../../../data/providers/school_repository.dart';
import '../../MySchool/main_screen.dart';
import '../ecommerce_home.dart';
import 'tab views/books_view.dart';


class ProductScreen extends StatefulWidget {
  static const route = '/product_screen';
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController in the initState method
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is disposed
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
          // Your content for the second tab
          Forms(),
          // Your content for the third tab
          Center(child: Text('Uniform')),
          // Your content for the fourth tab
          AboutSchool(),
        ],
      ),
    );
  }
}




































