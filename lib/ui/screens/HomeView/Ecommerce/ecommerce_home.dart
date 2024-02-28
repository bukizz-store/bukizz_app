import 'package:bukizz/data/models/ecommerce/products/product_model.dart';
import 'package:bukizz/data/providers/tabController/TabController_provider.dart';
import 'package:bukizz/data/repository/banners/banners.dart';
import 'package:bukizz/data/repository/product/product_view_repository.dart';
import 'package:bukizz/data/repository/product/uniform.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Stationary/general_product_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/form_view.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/tab_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/view_all_schools.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/view_all_stationary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/font_family.dart';
import '../../../../data/providers/school_repository.dart';
import '../../../../data/repository/category/category_repository.dart';
import '../../../../data/repository/product/general_product.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/images/Reusable_SliderImage.dart';
import '../../../../widgets/text and textforms/Reusable_text.dart';

class EcommerceMain extends StatefulWidget {

  const EcommerceMain({Key? key}) : super(key: key);

  @override
  State<EcommerceMain> createState() => _EcommerceMainState();
}

class _EcommerceMainState extends State<EcommerceMain> {

  List<String> emojiText = [
    "School BookSets",
    "Stationary",
    "School Admission",
    "Uniform",
    "Extras",
  ];
  List<String> stationaryText = [
    'School Bags',
    'Min. 50% Off',
    '18 Notebook Set',
    '@ Rs. 200/-'
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
    // var func = Provider.of<ProductModel>(context, listen: false);
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    var categoryRepo = Provider.of<CategoryRepository>(context, listen: false);
    var banner= context.read<BannerRepository>();
    var general= Provider.of<GeneralProductRepository>(context, listen: false);
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
              Builder(
                builder: (context) {

                  if(banner.banners1.isEmpty){
                    return Center(
                      child: Shimmer.fromColors(

                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 330,
                          height: 178,
                          decoration: BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),

                        ),
                      ),
                    );
                  }
                  return Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return RoundedImage(
                            onPressed: ()async{
                              // print(banner.banners1[index].link);
                              // Uri url = Uri.parse('https://fikfap.com/');
                              // await launchUrl(url);
                              // ProductModel.addProductData();
                            },
                              width: dimensions.screenWidth,
                              height:dimensions.height192,
                              isNetworkImage: true,
                              imageUrl: banner.banners1[index].image,
                          );
                        },
                        // items: [
                        //   RoundedImage(
                        //     width: dimensions.screenWidth,
                        //     height: dimensions.height192,
                        //     isNetworkImage: true,
                        //     imageUrl: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/banners%2Fslider1%2Fbanner1.jpg?alt=media&token=07a8dbea-31e2-43d6-bce8-90223eb13cc0',
                        //   ),
                        //   RoundedImage(
                        //     width: dimensions.screenWidth,
                        //     height: dimensions.height192,
                        //     isNetworkImage: true,
                        //     imageUrl: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/banners%2Fslider1%2Fbanner3.jpg?alt=media&token=0cf88ad2-203f-468b-8a8b-1c037da3713a',
                        //   ),
                        // ],

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
                          dotsCount:2,
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
                  );
                }
              ),

              SizedBox(height: dimensions.height16),
              //listview of icons
              Container(
                height: 46.sp,
                padding: EdgeInsets.only(left: dimensions.width16),
                // color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(right: 20.sp),
                      height: dimensions.height10 * 7.5,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(index==0){
                                context.read<TabProvider>().navigateToTab(0);
                                Navigator.pushNamed(context,ViewAll.route );
                              }
                              else if(index==1){
                                Navigator.pushNamed(context, ViewAllStationaryScreen.route);
                              }
                              else if(index==2){
                                context.read<TabProvider>().navigateToTab(1);
                                Navigator.pushNamed(context, ViewAll.route);
                              }
                              else if(index==3){
                                context.read<TabProvider>().navigateToTab(2);
                                Navigator.pushNamed(context, ViewAll.route);
                              }
                              else{
                                context.read<TabProvider>().navigateToTab(3);
                                Navigator.pushNamed(context, ViewAll.route);
                              }

                            },
                            child: CircleAvatar(
                                radius: dimensions.height48 / 2,
                                backgroundColor: const Color(0xFFCCE8FF),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        dimensions.height48 / 2),
                                    child: SvgPicture.asset(
                                      'assets/ecommerce home/icons/${index + 1}.svg',
                                      alignment: Alignment.center,
                                    )
                                )
                            ),
                          ),
                          SizedBox(
                            height: dimensions.height16 / 2,
                          ),
                          SizedBox(
                            width: 18.w,
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

              SizedBox(height: dimensions.height16/2),

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
                            fontSize: 16,
                            height: 0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00579E),
                          ),
                          const Icon(
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
                      height: 50.sp,
                      width: dimensions.width195,
                      margin: EdgeInsets.only(left: 3.8.w),
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
                              context.read<UniformRepository>().getUniformFromFirebase(schoolData.selectedSchool.uniformId);
                              context
                                  .read<ProductViewRepository>()
                                  .getProductData(
                                      schoolData.schoolDetails.productsId);
                              context.read<TabProvider>().navigateToTab(0);
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
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.00, -1.00),
                                        end: Alignment(0, 1),
                                        colors: [Colors.black.withOpacity(0.4), Colors.black],
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
                                          blurStyle: BlurStyle.solid,
                                          color: Color(0x4C00579E), // Shadow color
                                          spreadRadius: 0, // Spread radius
                                          blurRadius: 7, // Blur radius
                                          offset: Offset(0, 3), // Changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl:  schoolData.schoolData[index].banner,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.low,
                                        height: dimensions.height151,
                                        width: dimensions.width195,

                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 30),
                                          height: 40.sp,
                                          width: dimensions.width169,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: const Alignment(
                                                    0.00, -1.00),
                                                end: const Alignment(0, 0),
                                                colors: [
                                                  Colors.black.withOpacity(0),
                                                  Colors.black.withOpacity(0.75)
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
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                schoolData.schoolData[index].name,
                                                style: const TextStyle(
                                                    fontFamily: 'nunito',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFF9F9F9),
                                                    fontSize: 16,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                              ),

                                              SizedBox(
                                                height: dimensions.height10/4,
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
                                                    text: schoolData.schoolData[index].address,
                                                    fontSize: 12,
                                                    color: Color(0xFFF9F9F9),
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis,
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
                                          Colors.black.withOpacity(0.6)
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
              Builder(
                  builder: (context) {

                    if(banner.banners2.isEmpty){
                      return Shimmer.fromColors(

                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 330,
                          height: 178,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),

                        ),
                      );
                    }
                    return Stack(
                      children: [
                        CarouselSlider.builder(
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index, int realIndex) {
                            return RoundedImage(
                              onPressed: ()async{
                                Uri url = Uri.parse(banner.banners2[index].link);
                                await launchUrl(url);
                              },
                              width: dimensions.screenWidth,
                              height:dimensions.height192,
                              isNetworkImage: true,
                              imageUrl: banner.banners2[index].image,
                            );
                          },
                          // items: [
                          //   RoundedImage(
                          //     width: dimensions.screenWidth,
                          //     height: dimensions.height192,
                          //     isNetworkImage: true,
                          //     imageUrl: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/banners%2Fslider1%2Fbanner1.jpg?alt=media&token=07a8dbea-31e2-43d6-bce8-90223eb13cc0',
                          //   ),
                          //   RoundedImage(
                          //     width: dimensions.screenWidth,
                          //     height: dimensions.height192,
                          //     isNetworkImage: true,
                          //     imageUrl: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/banners%2Fslider1%2Fbanner3.jpg?alt=media&token=0cf88ad2-203f-468b-8a8b-1c037da3713a',
                          //   ),
                          // ],

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
                    );
                  }
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
                              // context.read<GeneralProductRepository>().sendGeneralProductToFirebase();
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
              categoryRepo.category.isNotEmpty?
              Container(
                height: dimensions.height10 * 17,
                width: dimensions.screenWidth,
                // color: Colors.red,
                padding: EdgeInsets.only(left: dimensions.width16),
                child: ListView.builder(
                    itemCount: categoryRepo.category.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                        // print(categoryRepo.category.length);
                      var selectedModel=categoryRepo.category[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<CategoryRepository>().selectedCategory = selectedModel;
                          context.read<GeneralProductRepository>().getGeneralProductFromFirebase(selectedModel.categoryId);
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   GeneralProductScreen(product: selectedModel.name)));
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
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fitHeight, imageUrl: selectedModel.image,
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
                                      text: selectedModel.name,
                                      fontSize: 14,
                                      color: Color(0xFF444444),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      height: dimensions.height10 * 2,
                                    ),
                                    ReusableText(
                                      text: selectedModel.offers,
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
              ):Center(child: SpinKitChasingDots(color: AppColors.primaryColor, size: 24,)),
              SizedBox(height: dimensions.height36),
            ],
          ),
        ),
      ),
    );
  }
}
