import 'package:bukizz_1/constants/colors.dart';
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
                child: Stack(
                  children: [
                    CarouselSlider(
                      items:  [
                        RoundedImage(width: dimensions.screenWidth, height: 192, isNetworkImage: false, assetImage: 'assets/ecommerce home/banner1.png',  ),
                        RoundedImage(width: dimensions.screenWidth, height: 192, isNetworkImage: false, assetImage: 'assets/ecommerce home/banner1.png', ),
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
                          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: dimensions.height16),


              //listview of icons
              Container(
                height: dimensions.height57,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: dimensions.width29),
                      height: dimensions.height57,
                      child: CircleAvatar(
                        radius: dimensions.height48/2 ,
                        backgroundColor: Color(0xFFCCE8FF),
                        child: Icon(Icons.book,color: AppColors.primaryColor,),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: dimensions.height32),

              //hardcoded text view your school
              Container(
                margin:EdgeInsets.symmetric(horizontal:dimensions.height24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: 'Pick Your School', fontSize: 20, height: 0,fontWeight: FontWeight.w700,color:  Color(0xFF121212),),
                    
                    Row(
                      children: [
                        ReusableText(text: 'View all', fontSize: 14, height: 0,fontWeight: FontWeight.w600,color: Color(0xFF00579E),),
                        Icon(Icons.arrow_forward,color: Color(0xFF00579E),size: 18,),
                      ],
                    )
                  ],
                ),
              ),

              //  schoolData.schoolData[index].banner,

              // ListView of schools
              Container(
                height: dimensions.height151,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: schoolData.schoolData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        schoolData.setSchoolName(schoolData.schoolData[index].name);
                        Navigator.pushNamed(context, ProductScreen.route);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Container(
                              height: dimensions.height151,
                              child: Image.asset( schoolData.schoolData[index].banner),
                            ),
                            Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Center(child: ReusableText(text: 'Wisdom World School', fontSize: 14, height: 0.10,fontWeight: FontWeight.w700,color: Color(0xFFF9F9F9),)))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: dimensions.height16),

              //2nd slider
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    CarouselSlider(
                      items:  [
                        RoundedImage(width: dimensions.screenWidth, height: 192, isNetworkImage: false, assetImage: 'assets/ecommerce home/banner2.png',  ),
                        RoundedImage(width: dimensions.screenWidth, height: 192, isNetworkImage: false, assetImage: 'assets/ecommerce home/banner2.png', ),
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
                          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: dimensions.height16),

              //buy stationary text
              Container(
                margin:EdgeInsets.symmetric(horizontal:dimensions.height24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: 'Buy Stationary', fontSize: 20, height: 0,fontWeight: FontWeight.w700,color:  Color(0xFF121212),),

                    Row(
                      children: [
                        ReusableText(text: 'View all', fontSize: 14, height: 0,fontWeight: FontWeight.w600,color: Color(0xFF00579E),),
                        Icon(Icons.arrow_forward,color: Color(0xFF00579E),size: 18,),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: dimensions.height16),



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

