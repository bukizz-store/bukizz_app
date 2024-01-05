import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/product_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/font_family.dart';
import '../../../../data/providers/school_repository.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/images/Reusable_Card.dart';
import '../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../widgets/images/Reusable_SliderImage.dart';
import '../../../../widgets/text and textforms/Reusable_text.dart';
import 'Cart/cart_screen.dart';

class EcommerceMain extends StatefulWidget {
  const EcommerceMain({Key? key}) : super(key: key);

  @override
  State<EcommerceMain> createState() => _EcommerceMainState();
}

class _EcommerceMainState extends State<EcommerceMain> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  late double _height;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    schoolData.schoolTemporaryData();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    _height = dimensions.pageViewContainer;
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding:
            EdgeInsets.fromLTRB(
              dimensions.width24,
              dimensions.height16,
              dimensions.width24,
              0,
            ),
            child: Column(

              children: [
                // Slider
                CarouselSlider(
                  items: const [
                    RoundedImage(width: 392, height: 192, isNetworkImage: false, assetImage: 'assets/banner1.png'),
                    RoundedImage(width: 392, height: 192, isNetworkImage: false, assetImage: 'assets/banner1.png'),
                  ],
                  options: CarouselOptions(
                    viewportFraction: 1,
                    aspectRatio: 2.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currPageValue = index.toDouble();
                      });
                    },
                  ),
                ),

                // Dots
                DotsIndicator(
                  dotsCount: 2,
                  position: _currPageValue.toInt(),
                  decorator: DotsDecorator(
                    activeColor: Colors.blueAccent,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),

                SizedBox(height: dimensions.height24),

                // Featured book set and filters row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Featured Book Sets',
                      fontSize: 16,
                      height: 0.09,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF03045E),
                      fontFamily: FontFamily.roboto,
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: 'Filters',
                          fontSize: 14,
                          height: 0.09,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF444444),
                          fontFamily: FontFamily.roboto,
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ],
                ),

                SizedBox(height: dimensions.height16),

                // List of selected filters hard coded as of now
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableColoredBox(
                      width: 182,
                      height: 28,
                      backgroundColor: Color(0xFFF6FDFE),
                      borderColor: Color(0xFF194DAD),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReusableText(
                            text: 'Wisdom World School',
                            color: Color(0xFF194DAD),
                            fontSize: 14,
                            fontFamily: FontFamily.roboto,
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.close),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: dimensions.height32),

                // ListView
                Container(
                  height: dimensions.height240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: schoolData.schoolData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: dimensions.width24),
                        child: ReusableCard(
                          width: 197,
                          height: 189,
                          //example url from web
                          imageUrl: schoolData.schoolData[index].banner,
                          title: schoolData.schoolData[index].name,
                          schoolName: schoolData.schoolData[index].name,
                          starCount: 5,
                          borderColor: Color(0xFFE8E8E8),
                          className: 'Class 2',
                          subject: 'Science & Math',
                          onTap: () {
                            schoolData.setSchoolName(schoolData.schoolData[index].name);
                            Navigator.pushNamed(context, ProductScreen.route);
                          },
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: dimensions.height36),

                // Admission application filter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Admission Applications',
                      fontSize: 16,
                      height: 0.09,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF03045E),
                      fontFamily: FontFamily.roboto,
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: 'Filters',
                          fontSize: 14,
                          height: 0.09,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF444444),
                          fontFamily: FontFamily.roboto,
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ],
                ),

                SizedBox(height: dimensions.height16),

                // Filters selected hardcoded as of now
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableColoredBox(
                      width: 182,
                      height: 28,
                      backgroundColor: Color(0xFFF6FDFE),
                      borderColor: Color(0xFF194DAD),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReusableText(
                            text: 'Wisdom World School',
                            color: Color(0xFF194DAD),
                            fontSize: 14,
                            fontFamily: FontFamily.roboto,
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.close),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
       print(index);
      if (_selectedIndex == 1) {
        // If index is 1, navigate to the cart screen
        Navigator.pushNamed(context, Cart.route);
      }
      else{
        //handle other indexes
      }
      // Handle navigation to the corresponding screen based on the index
      // You can use Navigator or other navigation methods here.
    });
  }
}

