import 'package:bukizz/data/repository/product_view_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Stationary/Bags/stationary_products.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/view_all_schools.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/view_all_stationary.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../constants/font_family.dart';
import '../../../../data/providers/school_repository.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/images/Reusable_SliderImage.dart';
import '../../../../widgets/text and textforms/Reusable_text.dart';

class EcommerceMain extends StatefulWidget {
  const EcommerceMain({Key? key}) : super(key: key);

  @override
  State<EcommerceMain> createState() => _EcommerceMainState();
}

class _EcommerceMainState extends State<EcommerceMain> {
  List iconSeq = [1, 4, 3, 2, 5];
  List<String> emojiText = [
    "School BookSets",
    "Uniform",
    "School Admission",
    "Stationary",
    "Extras",
  ];
  List<String> stationaryText = [
    'School Bags',
    'Min. 50% Off',
    '18 Notebook Set',
    '@ Rs. 200/-'
  ];
  List routes = [
    ViewAll.route,
    ViewAll.route,
    ViewAll.route,
    ViewAllStationaryScreen.route,
    ViewAllStationaryScreen.route
  ];

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
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    // schoolData.loadData(context);
    return Scaffold(
      //container of screen size
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // margin: ,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Slider 1
              Container(
                // padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
                // color: Colors.red,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        RoundedImage(
                          width: dimensions.screenWidth,
                          height: dimensions.height192,
                          isNetworkImage: false,
                          assetImage: 'assets/ecommerce home/banner1.jpg',
                        ),
                        RoundedImage(
                          width: dimensions.screenWidth,
                          height: dimensions.height192,
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
                      bottom:
                          dimensions.height10, // Adjust the position as needed
                      left: 0.0,
                      right: 0.0,
                      child: DotsIndicator(
                        dotsCount: 2,
                        position: _currPageValue.toInt(),
                        decorator: DotsDecorator(
                          activeColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Adjust radius to make it circular
                          ),
                          size: const Size.square(4.50),
                          activeSize: const Size.square(
                              9.0), // Make active dot circular
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: dimensions.height16),
              //listview of icons
              Container(
                height: dimensions.height10 * 11,
                padding: EdgeInsets.only(left: dimensions.width16),
                // color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      // color: Colors.green,
                      padding: EdgeInsets.only(right: dimensions.width10 * 1.6),
                      height: dimensions.height10 * 7.5,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, routes[index]);
                            },
                            child: CircleAvatar(
                                radius: dimensions.height48 / 2,
                                // backgroundColor: Color(0xFFCCE8FF),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        dimensions.height48 / 2),
                                    child: SvgPicture.asset(
                                      'assets/ecommerce home/icons/${iconSeq[index]}.svg',
                                      alignment: Alignment.center,
                                    ))),
                          ),
                          SizedBox(
                            height: dimensions.height16 / 2,
                          ),
                          SizedBox(
                            width: dimensions.width10 * 7,
                            child: Text(
                              emojiText[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF444444),
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: dimensions.height16),

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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ViewAll.route);
                      },
                      child: Row(
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
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: dimensions.height16),

              // ListView of schools
              context.watch<SchoolDataProvider>().schoolData.isNotEmpty
                  ? Container(
                      height: dimensions.height151,
                      width: dimensions.width195,
                      margin: EdgeInsets.only(left: dimensions.width16),
                      // color: Colors.red,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: schoolData.schoolData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              schoolData.setSchoolName(
                                  schoolData.schoolData[index].name,
                                  schoolData.schoolData[index].schoolId);
                              context
                                  .read<ProductViewRepository>()
                                  .getProductData(
                                      schoolData.schoolDetails.productsId);
                              Navigator.pushNamed(context, TabScreen.route);
                            },
                            //
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: dimensions.width16),
                              child: Stack(
                                children: [
                                  Container(
                                    height: dimensions.height10*14,
                                    width: dimensions.width169,
                                    decoration: ShapeDecoration(
                                      // gradient: LinearGradient(
                                      //   begin: Alignment(-0.00, -1.00),
                                      //   end: Alignment(0, 1),
                                      //   colors: [Colors.black.withOpacity(0.4), Colors.black],
                                      // ),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.50,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                          color: Color(0xFFD6D6D6),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x4C00579E),
                                          blurRadius: 12,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        schoolData.schoolData[index].banner,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.low,
                                        height: dimensions.height151,
                                        width: dimensions.width195,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: dimensions.height10*7,
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 12, top: 30),
                                          height: dimensions.height10*7,
                                          width: dimensions.width169,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: const Alignment(
                                                    0.00, -1.00),
                                                end: const Alignment(0, 0),
                                                colors: [
                                                  Colors.black.withOpacity(0),
                                                  Colors.black
                                                ],
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                text: schoolData
                                                    .schoolData[index].name,
                                                fontSize: 14,
                                                color: Color(0xFFF9F9F9),
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: dimensions.height10,
                                              ),
                                              Row(
                                                children: [
                                                 const Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        dimensions.width24 / 6,
                                                  ),
                                                  ReusableText(
                                                    text: schoolData
                                                        .schoolData[index].city,
                                                    fontSize: 12,
                                                    color: Color(0xFFF9F9F9),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              )
                                            ],
                                          )))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: dimensions.height151,
                      width: dimensions.width195,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: dimensions.width16 * 0.8,
                                vertical: dimensions.height8),
                            child: InkWell(
                              onTap: () {},
                              //
                              child: Stack(
                                children: [
                                  Container(
                                    height: dimensions.height151,
                                    width: dimensions.width169,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(-0.00, -1.00),
                                        end: const Alignment(0, 1),
                                        colors: [
                                          Colors.black.withOpacity(0),
                                          Colors.black
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 0.50,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                          color: Color(0xFFD6D6D6),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x4C00579E),
                                          blurRadius: 12,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    // child: ClipRRect(
                                    //   borderRadius: BorderRadius.circular(12),
                                    //   child: Image.network(
                                    //     schoolData.schoolData[index].banner,
                                    //     fit: BoxFit.cover,
                                    //     filterQuality: FilterQuality.low,
                                    //     height: dimensions.height151,
                                    //     width: dimensions.width195,
                                    //   ),
                                    // ),
                                  ),

                                  // Positioned(
                                  //     left: dimensions.width16/2,
                                  //     right: 0,
                                  //     bottom: dimensions.height8*2.5,
                                  //     child: ReusableText(text: schoolData.schoolData[index].name, fontSize: 14,color: Color(0xFFF9F9F9),fontWeight: FontWeight.w700,)
                                  // )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              SizedBox(height: dimensions.height16),

              //2nd slider
              Container(
                // padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
                // color: Colors.red,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: [
                        RoundedImage(
                          width: dimensions.screenWidth,
                          height: dimensions.height192,
                          isNetworkImage: false,
                          assetImage: 'assets/ecommerce home/banner1.jpg',
                        ),
                        RoundedImage(
                          width: dimensions.screenWidth,
                          height: dimensions.height192,
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
                      bottom:
                          dimensions.height10, // Adjust the position as needed
                      left: 0.0,
                      right: 0.0,
                      child: DotsIndicator(
                        dotsCount: 2,
                        position: _currPageValue.toInt(),
                        decorator: DotsDecorator(
                          activeColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Adjust radius to make it circular
                          ),
                          size: const Size.square(4.50),
                          activeSize: const Size.square(
                              9.0), // Make active dot circular
                        ),
                      ),
                    ),
                  ],
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
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ViewAllStationaryScreen.route);
                            },
                            child: ReusableText(
                              text: 'View all',
                              fontSize: 14,
                              height: 0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00579E),
                            )),
                        const Icon(
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
                height: dimensions.height10 * 17,
                width: dimensions.screenWidth,
                // color: Colors.red,
                padding: EdgeInsets.only(left: dimensions.width16),
                child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, BagViewAll.route);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: dimensions.width16,bottom: dimensions.height10),
                          width: dimensions.width146,
                          height: dimensions.height10,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFFD6D6D6),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x2600579E),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: dimensions.width146,
                                height: dimensions.height10 * 9,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    child: Image.asset(
                                      'assets/stationary/${index + 1}.jpg',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: dimensions.width24 / 3,
                                    vertical: dimensions.height10 * 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                      text: stationaryText[2 * index],
                                      fontSize: 14,
                                      color: Color(0xFF444444),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      height: dimensions.height10 * 2,
                                    ),
                                    ReusableText(
                                      text: stationaryText[2 * index + 1],
                                      fontSize: 14,
                                      color: Color(0xFF121212),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: dimensions.height36),
            ],
          ),
        ),
      ),
    );
  }
}
