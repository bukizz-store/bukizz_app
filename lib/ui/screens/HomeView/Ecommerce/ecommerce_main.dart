import 'package:bukizz_1/data/models/ecommerce/product_model.dart';
import 'package:bukizz_1/data/repository/product_view_repository.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/product_screen.dart';
// import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/tab_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
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
  List<String> emojiText = [
    "Books",
    "Forms",
    "Uniform",
    "Stationary",
    "Extras",
  ];

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  late double _height;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    schoolData.loadData();
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
      //container of screen size
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Slider
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: [
                          RoundedImage(
                            width: dimensions.screenWidth,
                            height: 192,
                            isNetworkImage: false,
                            assetImage: 'assets/ecommerce home/banner1.png',
                          ),
                          RoundedImage(
                            width: dimensions.screenWidth,
                            height: 192,
                            isNetworkImage: false,
                            assetImage: 'assets/ecommerce home/banner1.png',
                          ),
                        ],
                        options: CarouselOptions(
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 400),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currPageValue = index.toDouble();
                            });
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10.0, // Adjust the position as needed
                        left: 0.0,
                        right: 0.0,
                        child: DotsIndicator(
                          dotsCount: 2,
                          position: _currPageValue.toInt(),
                          decorator: DotsDecorator(
                            activeColor: Colors.blueAccent,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: dimensions.height16),
              //listview of icons
              Container(
                height: 65,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 29),
                      child: Container(
                        height: 65,
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: dimensions.height48 / 2,
                                backgroundColor: Color(0xFFCCE8FF),
                                child: Image.asset(
                                    'assets/ecommerce home/icons/${index + 1}.png')),
                            SizedBox(
                              height: 8,
                            ),
                            ReusableText(
                              text: emojiText[index],
                              fontSize: 14,
                              height: 0.10,
                              fontFamily: FontFamily.roboto,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF444444),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: dimensions.height32),

              //hardcoded text pick  your school
              Container(
                margin: EdgeInsets.symmetric(horizontal: dimensions.height24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Pick Your School',
                      fontSize: 20,
                      height: 0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF121212),
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: 'View all',
                          fontSize: 14,
                          height: 0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00579E),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF00579E),
                          size: 18,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: dimensions.height16),

              // ListView of schools
              //hardcoded again
              Container(
                height: dimensions.height151,
                width: dimensions.width195,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: schoolData.schoolData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        schoolData
                            .setSchoolName(schoolData.schoolData[index].name);
                        context.read<ProductViewRepository>().getProductData(
                            schoolData.schoolDetails.productsId);
                        Navigator.pushNamed(context, ProductScreen.route);
                      },
                      child: Container(
                          height: dimensions.height151,
                          width: dimensions.width169,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            // color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     // spreadRadius: 2,
                            //     // blurRadius: 5,
                            //     // offset: Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          // margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            children: [
                              Image.network(
                                schoolData.schoolData[index].banner,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                                height: dimensions.height151,
                                width: dimensions.width195,
                                // color: Colors.black.withOpacity(0.1),
                              ),
                              Container(
                                height: dimensions.height151,
                                width: dimensions.width169,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                )
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    schoolData.schoolData[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                ],
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),

              SizedBox(height: dimensions.height16),

              //2nd slider
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: [
                          RoundedImage(
                            width: dimensions.screenWidth,
                            height: 192,
                            isNetworkImage: false,
                            assetImage: 'assets/ecommerce home/banner2.png',
                          ),
                          RoundedImage(
                            width: dimensions.screenWidth,
                            height: 192,
                            isNetworkImage: false,
                            assetImage: 'assets/ecommerce home/banner2.png',
                          ),
                        ],
                        options: CarouselOptions(
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 4),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currPageValue = index.toDouble();
                            });
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10.0, // Adjust the position as needed
                        left: 0.0,
                        right: 0.0,
                        child: DotsIndicator(
                          dotsCount: 2,
                          position: _currPageValue.toInt(),
                          decorator: DotsDecorator(
                            activeColor: Colors.blueAccent,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: dimensions.height16),

              //buy stationary text
              Container(
                margin: EdgeInsets.symmetric(horizontal: dimensions.height24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Buy Stationary',
                      fontSize: 20,
                      height: 0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF121212),
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              // ProductModel.sendRandomProductData();
                              // schoolData.pushRandomData();
                            },
                            child: ReusableText(
                              text: 'View all',
                              fontSize: 14,
                              height: 0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00579E),
                            )),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF00579E),
                          size: 18,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: dimensions.height16),
              Container(
                height: dimensions.height151,
                width: dimensions.width195,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        schoolData
                            .setSchoolName(schoolData.schoolData[index].name);
                        Navigator.pushNamed(context, ProductScreen.route);
                      },
                      child: Container(
                          height: dimensions.height151,
                          width: dimensions.width169,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/stationary/${index + 1}.png',
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                ),
              ),
            ],
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.category),
          //   label: 'Category',
          // ),
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
      } else {
        //handle other indexes
      }
      // Handle navigation to the corresponding screen based on the index
      // You can use Navigator or other navigation methods here.
    });
  }
}
