import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

// Your existing imports
import '../../constants/font_family.dart';
import '../../utils/dimensions.dart';
import '../../widgets/Reusable_Card.dart';
import '../../widgets/Reusable_colored_box.dart';
import '../../widgets/Reusable_text.dart';
import '../../widgets/RoundedButton_slider.dart';


class EcommercePage extends StatefulWidget {
  const EcommercePage({Key? key}) : super(key: key);

  @override
  State<EcommercePage> createState() => _EcommercePageState();
}

class _EcommercePageState extends State<EcommercePage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  late double _height;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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
                    RoundedImage(width: 392, height: 192, isNetworkImage: false, assetImage: 'images/banner1.png'),
                    RoundedImage(width: 392, height: 192, isNetworkImage: false, assetImage: 'images/banner1.png'),
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
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: dimensions.width24),
                        child: ReusableCard(
                          width: 197,
                          height: 189,
                          //example url from web
                          imageUrl: "https://images.unsplash.com/photo-1624555130581-1d9cca783bc0?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          title: 'Class 2 - Science & Math Set',
                          schoolName: 'School 2',
                          starCount: 5,
                          borderColor: Color(0xFFE8E8E8),
                          className: 'Class 2',
                          subject: 'Science & Math',
                          onTap: () {
                            print('Card $index tapped!');
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
      // Handle navigation to the corresponding screen based on the index
      // You can use Navigator or other navigation methods here.
    });
  }
}
