import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/data/providers/tabController/TabController_provider.dart';

import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/about_school.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/form_view.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/form_view_2.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/uniform_view.dart';
import 'package:bukizz/widgets/containers/Reusable_ColouredBox.dart';
import 'package:bukizz/widgets/custom_tab/custom_tab2.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../../../../../../data/providers/school_repository.dart';
import 'books_view.dart';


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
    tabController.index = context.read<TabProvider>().currentIndex;

    tabController.addListener(() {
      // print("object");
      context.read<TabProvider>().navigateToTab(tabController.index);
      tabController.animateTo(tabController.index);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var schoolData = context.read<SchoolDataProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),onPressed: (){Navigator.of(context);},),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              schoolData.selectedSchool.name,
              style: const TextStyle(
                color: Color(0xFF121212),
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            SizedBox(height: 10.sp,),
            ReusableText(text: '${schoolData.selectedSchool.address},${schoolData.selectedSchool.city}, ${schoolData.selectedSchool.state}', fontSize: 14,color:  Color(0xFF7A7A7A),fontWeight: FontWeight.w500,)
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.sp),
          child: CustomTabBar2(
            tabController: tabController,
            onIndexChanged: (index) {
              // Handle tab index change if needed
              print(index);
              context.read<TabProvider>().navigateToTab(index);
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

          UniformScreen(),

          Forms2(),

          AboutSchool(),
        ],
      ),
    );
  }
}




































