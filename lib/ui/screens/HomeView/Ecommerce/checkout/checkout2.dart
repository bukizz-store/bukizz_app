import 'package:bukizz_1/constants/font_family.dart';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:bukizz_1/data/repository/order_view_repository.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../data/models/ecommerce/products/product_model.dart';
import '../../../../../data/providers/cart_provider.dart';
import '../../../../../widgets/buttons/cart_button.dart';
import '../../../../../widgets/circle/custom circleAvatar.dart';
import '../../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import '../Cart/cart_screen.dart';
import 'checkout3.dart';

class Checkout2 extends StatefulWidget {
  const Checkout2({super.key});

  @override
  State<Checkout2> createState() => _Checkout2State();
}

class _Checkout2State extends State<Checkout2> {

  String? selectedAddress;
  TextEditingController couponController=TextEditingController();
  String defaultAddress = "${AppConstants.userData.address.houseNo}, ${AppConstants.userData.address.street}, ${AppConstants.userData.address.city}, ${AppConstants.userData.address.state}, ${AppConstants.userData.address.pinCode}";

  double totalPrice = 0;
  double salePrice = 0;
  @override
  void initState() {
    super.initState();
    selectedAddress = defaultAddress;
  }
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    var orderDetail = context.read<OrderViewRespository>();
    return Consumer<CartViewRepository>(builder: (context , cartData , child){
      return Scaffold(
        appBar: AppBar(
          title: Text('Order summary'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: dimensions.height8*1.5,),
              //container with step 1 2 3
              Container(
                width: dimensions.screenWidth,
                height: dimensions.height8*11.5,
                color: Colors.white,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black38,
                      borderWidth: 0.10,
                      child: ReusableText(text: '1', fontSize: 16,color: Colors.white, height: null,),
                    ),
                    Container(
                      width: dimensions.width10*10,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '2', fontSize: 16,color: Colors.white),
                    ),
                    Container(
                      width: dimensions.width10*10,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Colors.transparent,
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '3', fontSize: 16,color: Color(0xFF058FFF),),
                    ),
                  ],
                ),
              ),

              SizedBox(height: dimensions.height8*1.5,),

              //address selection

              Container(
                width: dimensions.screenWidth,
                height: dimensions.height8*12,
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: dimensions.width24/3,vertical: dimensions.height8*1.5),
                    child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: defaultAddress,
                            groupValue: selectedAddress,
                            onChanged: (value) {
                              setState(() {
                                selectedAddress = value!;
                                print(selectedAddress);
                              });
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //deliver to : name
                              Flexible(
                                child: Row(
                                  children: [
                                    ReusableText(text: 'Deliver to: ', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis,),
                                    ReusableText(text: AppConstants.userData.name, fontSize: 16,color:Color(0xFF121212),fontWeight: FontWeight.w700,overflow: TextOverflow.clip,),
                                  ],
                                ),
                              ),

                              SizedBox(height: dimensions.height8*2,),
                              // address with overflow
                              Container(
                                width: dimensions.width24 * 9.5,
                                child: ReusableText(
                                  text: "${orderDetail.getUserAddress.houseNo}, ${orderDetail.getUserAddress.street}, ${orderDetail.getUserAddress.city}, ${orderDetail.getUserAddress.state}, ${orderDetail.getUserAddress.pinCode}",
                                  fontSize: 14,
                                  height: 0,
                                  color: Color(0xFF7A7A7A),
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: dimensions.width16/3,),
                          Padding(
                            padding:  EdgeInsets.only(top: dimensions.height8),
                            child: Container(
                              width: dimensions.width16*4,
                              height: dimensions.height8*4.5,

                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.50, color: Color(0xFFD6D6D6)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Center(child: ReusableText(text: 'Change', fontSize: 14,color: Color(0xFF00579E),fontWeight: FontWeight.w600,),),
                            ),
                          ),
                        ]
                    )
                ),
              ),

              SizedBox(height: dimensions.height8,),

              //cart products
              Column(
                children: _buildWidget(cartData, context, dimensions)

              ),

              SizedBox(height: dimensions.height8*1.5,),

              //apply coupon container

               Container(
                 width: dimensions.screenWidth,
                 // height: dimensions.height10*10.3,
                 color: Colors.white,
                 padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.width10*2),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     ReusableText(text: 'Apply Coupon', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w700,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           width: dimensions.width10*22.5,
                           height: dimensions.height40,
                           child: TextField(
                             controller: couponController,
                             decoration: InputDecoration(
                               prefixIcon:  Padding(
                                 padding: EdgeInsets.only(left: dimensions.height8 * 2),
                                 child: const Icon(
                                   Icons.local_offer,
                                   color: Color(0xFF058FFF),
                                 ),
                               ),
                               contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),
                               hintText: 'Coupon code',
                               hintStyle: TextStyle(color: Color(0xFF7A7A7A)),
                               border: const OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.black38),
                               ),
                               focusedBorder: const OutlineInputBorder(
                                 borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                               ),
                             ),
                           ),
                         ),
                         OutlinedButton(
                           onPressed: () {
                               //apply coupon logic here
                               ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                   content: Text('Invalid coupon. Please try again.'),
                                   duration: Duration(seconds: 2),
                                 ),
                               );
                           },
                           style: OutlinedButton.styleFrom(
                               shape: const RoundedRectangleBorder(
                                 side: BorderSide(color: Color(0xFF00579E), ),
                               ),
                               padding: EdgeInsets.symmetric(horizontal: dimensions.width10*2,vertical: dimensions.height10)
                           ),
                           child: ReusableText(
                             text: 'Apply',
                             fontSize: 14,
                             fontWeight: FontWeight.w600,
                             color: Color(0xFF00579E),
                           ),
                         ),
                       ],
                     )
                   ],
                 ),
               ),

              SizedBox(height: dimensions.height8*1.5,),

              //price distribution container
              Container(
                width: dimensions.screenWidth,
                height: dimensions.height29*6.3,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height8*2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: 'Price Detailes', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w700,),
                      SizedBox(height: dimensions.height8*3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Price (${cartData.cart_val} items) ', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,),
                          ReusableText(text: totalPrice.toString(), fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*2.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Discount', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,),
                          ReusableText(text: '-₹${totalPrice -salePrice}', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*2.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Delivery Charges', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,),
                          ReusableText(text: '₹40', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*1.5,),
                      Container(
                        width: dimensions.width24*14,
                        height: 1,
                        color: Color(0xFFD6D6D6),
                      ),
                      SizedBox(height: dimensions.height8*2.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Total Amount', fontSize: 14,color: Color(0xFF282828),fontWeight: FontWeight.w700,),
                          ReusableText(text: '₹${salePrice +40}', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*1.5,),
                      Container(
                        width: dimensions.width24*14,
                        height: 1,
                        color: Color(0xFFD6D6D6),
                      ),
                      SizedBox(height: dimensions.height8*1.5,),
                      ReusableText(text: 'You will save ₹${totalPrice -salePrice} on this order', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w600,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        bottomNavigationBar: Container(
          height: dimensions.height8 * 9,
          width: dimensions.screenWidth,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: dimensions.width24,right: dimensions.width24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price column
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (totalPrice+ 40).toString(),
                      style: TextStyle(
                        color: Color(0xFFB7B7B7),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '₹${salePrice +40}',
                      style: TextStyle(
                        color: Color(0xFF121212),
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: (){
                    if (selectedAddress == null) {
                      // Show a Snackbar if no address is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select an address first.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      // Navigate to the next screen or perform other actions

                      context.read<OrderViewRespository>().setOrderModelData(cartData.getTotalPrice +40, cartData.getSalePrice + 40, cartData.getCartData);
                      context
                          .read<CartViewRepository>()
                          .setTotalPrice(totalPrice.toInt());
                      context
                          .read<CartViewRepository>()
                          .setSalePrice(salePrice.toInt());

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Checkout3()),
                      );
                    }
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
    },);
  }

  String setProductName(String school , int set , int stream , ProductModel product){
    String streamName =  product.stream.isNotEmpty ?  "- ${product.stream[stream].name}" ?? '' : '';
    String setName =  product.set.isNotEmpty ?  "(${product.set[set].name})" ?? '' : '';
    return "$school - ${product.name}$streamName $setName";
  }

  int setTotalSalePrice(ProductModel product , int set , int stream){
    int totalSalePrice = product.salePrice;
    product.set.isNotEmpty ? totalSalePrice += int.parse(product.set[set].price): 0;
    product.stream.isNotEmpty ? totalSalePrice += int.parse(product.stream[stream].price ?? "0"): 0;
    return totalSalePrice;
  }

  int setTotalPrice(ProductModel product , int set , int stream){
    int totalPrice = product.price.floor();
    product.set.isNotEmpty ? totalPrice += int.parse(product.set[set].price): 0;
    product.stream.isNotEmpty ? totalPrice += int.parse(product.stream[stream].price ?? "0"): 0;
    return totalPrice;
  }

  List<Widget> _buildWidget(CartViewRepository cartData , BuildContext context , dimensions){
    List<Widget> list=[];
    totalPrice = 0;
    salePrice = 0;
    cartData.cartData.forEach((schoolName , productData){
      productData.forEach((product, setData) {
        setData.forEach((set, streamData) {
          streamData.forEach((stream, quantity) {
            ProductModel productModel = cartData.products.where((element) => element.productId == product).first;
            String productName = setProductName(schoolName, set, stream, productModel);
            int totalSalePrice = setTotalSalePrice(productModel, set, stream);
            int price = setTotalPrice(productModel, set, stream);
            totalPrice += price * quantity;
            salePrice += totalSalePrice * quantity;
                list.add(
                  Container(
                    // height: dimensions.height192,
                    width: dimensions.screenWidth,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dimensions.width24/1.5,
                        vertical: dimensions.height8/2,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //image and cart button
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: dimensions.width83,
                                    height: dimensions.height83,
                                    child: Image.network(cartData.products
                                        .where(
                                            (element) => element.productId == product)
                                        .first
                                        .image)),
                                  SizedBox(height: dimensions.height8),
                                  ReusableQuantityButton(
                                    quantity: quantity,
                                    height: 32,
                                    width: 83,
                                    productId: product,
                                    schoolName: schoolName,
                                    set: set,
                                    stream: stream,
                                    onChanged: (newQuantity) {
                                    },
                                  ),
                                ],
                              ),
                              //bookset name review and pricing
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: dimensions.height16,),

                                  //book names
                                  SizedBox(
                                    width: dimensions.width120*2,
                                    child:  Text(
                                        productName,
                                      style: const TextStyle(
                                        color: Color(0xFF121212),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  //stars for review
                                  Row(
                                    children: List.generate(
                                      5 ,
                                          (index) => const Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Color(0xFF058FFF),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: dimensions.height32,),
                                  RichText(
                                    text: TextSpan(
                                      text: "${((price - totalSalePrice)/price *100).round().toString()}% off ",
                                      style: TextStyle(
                                        color: AppColors.productButtonSelectedBorder,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        decoration: TextDecoration.none,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:price.toString(),

                                          style: const TextStyle(
                                            color: Color(0xFFB7B7B7),
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.lineThrough,
                                            fontSize: 16,
                                          ),
                                        ),

                                        TextSpan(
                                          text:
                                          " ₹${totalSalePrice.toString()}",
                                          style: const TextStyle(
                                            color: Color(0xFF121212),
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.none,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: dimensions.height36/4,),
                          Container(
                            width: dimensions.width342,
                            height: dimensions.height40,
                            child: InkWell(
                              onTap: (){
                                cartData.removeCartData(schoolName, product , set , stream);
                                context
                                    .read<CartProvider>()
                                    .removeCartData(schoolName, product,set , stream, context);
                                setState(() {});
                              },
                              child: ReusableColoredBox(
                                  width: dimensions.width146,
                                  height: dimensions.height36,
                                  backgroundColor: Colors.transparent,
                                  borderColor: Color(0xFFD6D6D6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReusableText(text: 'Remove', fontSize: 14, height: 0,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w600,),
                                      Icon(Icons.delete_outline,color: Color(0xFF7A7A7A) ,)
                                    ],
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: dimensions.height8,),
                          // const Divider(
                          //   height: 1.0,
                          //   color: Color(0xFFD6D6D6),
                          // ),
                        ],

                      ),
                    ),
                  ),
                );
          });
        });
      });
    });
    return list;
  }

}
