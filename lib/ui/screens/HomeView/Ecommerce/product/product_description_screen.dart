import 'package:bukizz/constants/font_family.dart';
import 'package:bukizz/constants/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:bukizz/data/providers/cart_provider.dart';
import 'package:bukizz/data/providers/school_repository.dart';
import 'package:bukizz/data/repository/product/product_view_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../data/providers/stationary_provider.dart';
import '../../../../../data/repository/cart_view_repository.dart';
import '../../../../../data/repository/category/category_repository.dart';
import '../../../../../data/repository/product/general_product.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../../widgets/review widget/review.dart';
import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../widgets/text and textforms/expandable_text_widget.dart';
import '../checkout/checkout1.dart';
import 'Stationary/general_product_screen.dart';

class ProductDescriptionScreen extends StatefulWidget {
  static const String route = '/productdescription';
  const ProductDescriptionScreen({super.key});

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  bool productAdded = false;
  TextEditingController pinController = TextEditingController();
  int _currPageValue=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pinController.text = AppConstants.userData.address.pinCode;
    checkDeliverable();
  }

  @override
  Widget build(BuildContext context) {
    var categoryRepo = Provider.of<CategoryRepository>(context, listen: false);
    var schoolData = context.read<SchoolDataProvider>();
    var stationaryData = context.read<StationaryProvider>();
    Dimensions dimensions = Dimensions(context);
    return Consumer<ProductViewRepository>(
      builder: (context, value, child) {
        // print(value.selectedProduct.variation);
        return Scaffold(



          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.sp,),
                //image for pageview container
                Stack(
                  children: [
                    Container(
                      width: dimensions.screenWidth,
                      height: dimensions.height16 * 20.75,
                      child: PageView.builder(
                        onPageChanged: (int page) {
                          setState(() {
                            _currPageValue = page;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()][value.getSelectedStreamDataIndex.toString()].image.length,
                        itemBuilder: (context,index){
                          return  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            // child: Image.asset('assets/school/perticular bookset/book.png',fit: BoxFit.contain,),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl: value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()][value.getSelectedStreamDataIndex.toString()].image[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 6.w,
                      top: 10.sp,
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,size: 25,)
                      ),
                    ),
                    if(value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()][value.getSelectedStreamDataIndex.toString()].image.length>1)
                    Positioned(
                      bottom: 5.sp,
                      left: 38.w,
                      child: DotsIndicator(
                        dotsCount:value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()][value.getSelectedStreamDataIndex.toString()].image.length,
                        position: _currPageValue.toInt(),
                        decorator: DotsDecorator(
                          activeColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Adjust radius to make it circular
                          ),
                          size: const Size.square(4.50),
                          activeSize: const Size.square(
                              9.0), // Make active dot circular
                        ),
                      ),
                    )
                  ],
                ),




                //book description container
                Container(
                  // height: dimensions.height8 * 13,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensions.width24,
                        vertical: dimensions.height8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              schoolData.selectedSchool.name,
                              style: const TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 18,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            SizedBox(height: 10.sp,),
                            ReusableText(text: '${schoolData.selectedSchool.address},${schoolData.selectedSchool.city}, ${schoolData.selectedSchool.state}', fontSize: 14,color:  Color(0xFF7A7A7A),fontWeight: FontWeight.w500,)
                          ],
                        ),
                        // SizedBox(
                        //   width: 345,
                        //   child: Text(
                        //     schoolData.selectedSchool.name,
                        //     style: const TextStyle(
                        //       color: Color(0xFF121212),
                        //       fontSize: 18,
                        //       fontFamily: 'Nunito',
                        //       fontWeight: FontWeight.w600,
                        //       height: 0,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: dimensions.height24 / 10,
                        // ),
                        // SizedBox(
                        //   width: 345,
                        //   child: Text(
                        //     'Branch : ${schoolData.selectedSchool.address},',
                        //     style: const TextStyle(
                        //       color: Colors.grey,
                        //       fontSize: 16,
                        //       fontFamily: 'Nunito',
                        //       fontWeight: FontWeight.w600,
                        //       height: 0,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: dimensions.height24 /2,
                        ),
                        SizedBox(
                          width: 345,
                          child: Text(
                            value.selectedProduct.name,
                            style: const TextStyle(
                              color: Color(0xFF121212),
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: dimensions.height24 / 4,
                        ),
                        Row(
                          children: [

                            ReusableText(text: 'MRP ', fontSize: 12,fontWeight: FontWeight.w400,),
                            Text(
                              value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()]![value.getSelectedStreamDataIndex.toString()]!.price.toString(),
                              style: const TextStyle(
                                color: Color(0xFF7A7A7A),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'nunito',
                              ),
                            ),

                            SizedBox(
                              width: dimensions.width24 / 4,
                            ),
                            //discounted price
                            Text(
                              '₹${value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()]![value.getSelectedStreamDataIndex.toString()]!.salePrice.toString()}',
                              style: const TextStyle(
                                color: Color(0xFF121212),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                // fontFamily: 'nunito'
                              ),
                            ),
                            SizedBox(width: dimensions.width16/2,),
                            ReusableText(
                              text:
                              '${(((value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()]![value.getSelectedStreamDataIndex.toString()]!.price - value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()]![value.getSelectedStreamDataIndex.toString()]!.salePrice) * 100 / value.selectedProduct.variation[value.getSelectedSetDataIndex.toString()]![value.getSelectedStreamDataIndex.toString()]!.price).round().toString())}% Off',
                              fontSize: 20,
                              color: Color(0xFF058FFF),
                              fontWeight: FontWeight.w700,
                              height: 0.11,
                              fontFamily: FontFamily.nunito,
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // ProductButtons(title: "Set", length: 2, selectedIndex: 0,),
                value.selectedProduct.set.isNotEmpty
                    ? Container(
                  // width: double.infinity,
                  padding: EdgeInsets.only(
                      left: dimensions.width24,
                      bottom: dimensions.height16),
                  // height: 200,
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Choose Set",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(height: 8),
                      Container(
                        height: 40,
                        child: ListView.builder(
                            itemCount: value.getProductDetail.set.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  value.setSelectedSetData(index);
                                  // value.setProductName(
                                  //     schoolData.selectedSchool.name);
                                  value.setSelectedIndex();
                                  value.setTotalSalePrice();
                                  value.setTotalPrice();
                                },
                                child: Container(
                                  height: 30,
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      color: value.getSelectedSetDataIndex ==
                                          index
                                          ? AppColors
                                          .productButtonSelectedBG
                                          : AppColors
                                          .productButtonUnSelectedBG,
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      border: Border.all(
                                        color: value.getSelectedSetDataIndex ==
                                            index
                                            ? AppColors
                                            .productButtonSelectedBorder
                                            : AppColors
                                            .productButtonUnSelectedBorder,
                                      )),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(value.getProductDetail
                                          .set[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'nunito'
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
                    : Container(),

                // SizedBox(height: 8,),
                value.selectedProduct.stream.isNotEmpty
                    ? Container(
                  // width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: dimensions.width24,
                  ),
                  // height: 200,
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Stream",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(height: 8),
                      Container(
                        height: 40,
                        child: ListView.builder(
                            itemCount:
                            value.getProductDetail.stream.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  value.setSelectedStreamData(index);
                                  // value.setProductName(
                                  //     schoolData.selectedSchool.name);
                                  value.setSelectedIndex();
                                  value.setTotalSalePrice();
                                  value.setTotalPrice();
                                },
                                child: Container(
                                  height: 40,
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      color: value.getSelectedStreamDataIndex ==
                                          index
                                          ? AppColors
                                          .productButtonSelectedBG
                                          : AppColors
                                          .productButtonUnSelectedBG,
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      border: Border.all(
                                        color: value.getSelectedStreamDataIndex ==
                                            index
                                            ? AppColors
                                            .productButtonSelectedBorder
                                            : AppColors
                                            .productButtonUnSelectedBorder,
                                      )),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(value.getProductDetail
                                          .stream[index].name),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
                    : Container(),

                //expandable text
                SizedBox(
                  height: dimensions.height16 / 2,
                ),
                ExpandableTextWidget(
                    title: "Description",
                    text: value.selectedProduct.description),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: dimensions.width24,
                      top: dimensions.height16,
                      bottom: dimensions.height16,
                      right: dimensions.width24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: 'Delivery & Services',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF121212),
                      ),
                      SizedBox(
                        height: dimensions.height8 * 3,
                      ),
                      ReusableText(
                        text: 'Enter Delivery Pincode',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF444444),
                      ),
                      SizedBox(
                        height: dimensions.height8,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: dimensions.screenWidth,
                        height: 27.sp,
                        child: TextField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          controller: pinController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: dimensions.height8 * 2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                  width: 0.50, color: Color(0xFFB7B7B7)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                  width: 0.50, color: Color(0xFFB7B7B7)),
                            ),
                            suffixIcon:    InkWell(

                              onTap: () {
                                checkDeliverable();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Check',
                                  style: TextStyle(
                                    color: Color(0xFF058FFF),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            counterText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: dimensions.height8,
                      ),
                      isDeliverable
                          ? Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: Color(0xFF39A7FF),
                          ),
                          SizedBox(
                            width: dimensions.width10 / 2,
                          ),
                          //code for displaying the delivery date two day after the today date and time
                          ReusableText(
                            text: 'Estimated delivery within 2 days',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF444444),
                          )
                        ],
                      )
                          : Row(
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: AppColors.red,
                          ),
                          SizedBox(
                            width: dimensions.width10 / 2,
                          ),
                          //code for displaying the delivery date two day after the today date and time
                          ReusableText(
                            text: 'Delivery Unavailable at this Pin code',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.red,
                          )
                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: dimensions.height8,
                ),

                // accesories
                ReusableColoredBox(
                  width: dimensions.screenWidth,
                  height: dimensions.height8 * 27,
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensions.width24,
                        vertical: dimensions.height16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //complete your set with -> text
                        ReusableText(
                          text: 'Complete your set',
                          fontSize: 18,
                          height: 0.09,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF121212),
                        ),
                        SizedBox(
                          height: dimensions.height16,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: () {

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
                                                fit: BoxFit.fitHeight, imageUrl: 'https://m.media-amazon.com/images/I/514KCkOF+pL._SY300_SX300_.jpg',
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: dimensions.width24 / 3,
                                              vertical: dimensions.height10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                text: 'Pencil',
                                                fontSize: 14,
                                                color: Color(0xFF444444),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                height: dimensions.height10 * 2,
                                              ),
                                              ReusableText(
                                                text:'20 % off',
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
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: dimensions.height24 ,
                ),

                Padding(
                    padding: EdgeInsets.only(left: dimensions.width24),
                    child: ReusableText(text: 'Frequently Brought Together', fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xFF121212),)),
                SizedBox(height: dimensions.height24,),
                categoryRepo.category.isNotEmpty?
                Container(
                  height: dimensions.height10 * 17,
                  width: dimensions.screenWidth,
                  // color: Colors.red,
                  padding: EdgeInsets.only(left: dimensions.width24),
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
                SizedBox(height: dimensions.height8),

                ReviewListWidget(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: dimensions.height8 * 9,
            width: dimensions.screenWidth,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: dimensions.width24,
                  vertical: dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      // context.read<CartProvider>().addProductInCart(
                      //     productView.selectedProduct.productId, context);
                      context.read<CartViewRepository>().isSingleBuyNow = false;
                      productAdded
                          ? send()
                          : await context
                          .read<CartProvider>()
                          .addProductInCart(
                          schoolData.selectedSchool.name,
                          value.selectedProduct
                              .set[value.getSelectedSetDataIndex].name,
                          value.selectedProduct.stream.isNotEmpty
                              ? value
                              .selectedProduct
                              .stream[
                          value.getSelectedStreamDataIndex]
                              .name
                              : '0',
                          1,
                          value.selectedProduct.productId,
                          context,
                          'bookset')
                          .then((value) =>
                          AppConstants.showCartSnackBar(context));

                      setState(() {
                        productAdded = true;
                      });

                      // context.read<CartViewRepository>().setCartData(
                      //     schoolData.schoolName,
                      //     context
                      //         .read<CartProvider>()
                      //         .getCartData
                      //         .productsId[productView.selectedProduct.productId]!,
                      //     productView.selectedProduct.productId);
                    },
                    child: Container(
                      height: dimensions.height8 * 6,
                      width: dimensions.width146,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                          BorderSide(width: 0.50, color: Color(0xFF00579E)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableText(
                            text: productAdded ? 'Go to Cart' : 'Add to Cart',
                            fontSize: 16,
                            height: 0.11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF00579E),
                          ),
                          const Icon(
                            Icons.shopping_cart,
                            color: Color(0xFF00579E),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {

                      var cartView = context.read<CartViewRepository>();
                      cartView.isSingleBuyNow = true;
                      cartView.setTotalPrice(value
                          .selectedProduct
                          .variation[value.getSelectedSetDataIndex.toString()]![
                      value.getSelectedStreamDataIndex.toString()]!
                          .price);
                      cartView.setSalePrice(value
                          .selectedProduct
                          .variation[value.getSelectedSetDataIndex.toString()]![
                      value.getSelectedStreamDataIndex.toString()]!
                          .salePrice);
                      await context.read<CartViewRepository>().getCartProduct(
                          value.selectedProduct.productId,
                          schoolData.selectedSchool.name,
                          value.selectedProduct
                              .set[value.getSelectedSetDataIndex].name,
                          value.selectedProduct.stream.isNotEmpty
                              ? value.selectedProduct
                              .stream[value.getSelectedStreamDataIndex].name
                              : '0',
                          1,
                          AppString.bookSetType);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Checkout1()),
                      );
                    },
                    child: Container(
                      height: dimensions.height8 * 6,
                      width: dimensions.width146,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xFF058FFF),
                      ),
                      child: Center(
                        child: ReusableText(
                          text: 'Buy Now',
                          fontSize: 16,
                          height: 0.11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void send() {
    context.read<BottomNavigationBarProvider>().setSelectedIndex(1);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(MainScreen.route, (route) => false);
  }

  bool isDeliverable = false;

  Future<void> checkDeliverable() async {
    if(pinController.text.length < 6)
    {
      AppConstants.showSnackBar(context, "Please Enter Valid Pincode", Colors.red, Icons.error_outline_rounded , time: 1);
      return;
    }
    await FirebaseDatabase.instance
        .ref()
        .child('pincode')
        .child(context.read<SchoolDataProvider>().selectedSchool.city)
        .get()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        if (snapshot.value.toString().contains(pinController.text)) {
          setState(() {
            isDeliverable = true;
          });
          print('pincode found');
        } else {
          setState(() {
            isDeliverable = false;
          });
          print('pincode not found');
        }
      } else {
        setState(() {
          isDeliverable = false;
        });
        print('Location not Exist');
      }
    });
  }

  void checkDeliveryDate() {
    DateTime now = DateTime.now();

    // Calculate delivery date
    DateTime deliveryDate = now.add(const Duration(days: 2));

    // Format the delivery date
    String formattedDeliveryDate =
    DateFormat('yyyy-MM-dd HH:mm:ss').format(deliveryDate);

    // Display the delivery date
    print('Delivery Date: $formattedDeliveryDate');
  }
}
