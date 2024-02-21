import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/constants/font_family.dart';
import 'package:bukizz/data/repository/cart_view_repository.dart';
import 'package:bukizz/data/repository/product_view_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/buttons/cart_button.dart';
import 'package:bukizz/widgets/containers/Reusable_ColouredBox.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/ecommerce/products/product_model.dart';
import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../data/providers/cart_provider.dart';
import '../checkout/checkout1.dart';
import 'empty_cart_screen.dart';

class Cart extends StatefulWidget {
  static const String route = '/cart';
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  double totalPrice = 0;
  double salePrice = 0;

  // bool load = false;

  @override
  Widget build(BuildContext context) {
    var provider = context.read<BottomNavigationBarProvider>();
    Dimensions dimensions = Dimensions(context);
    print('CartUpdated');
    // var cartData = context.watch<CartViewRepository>();
    var cartProvider = context.read<CartProvider>();
    // cartProvider.loadCartData(context);
    return Consumer<CartViewRepository>(
        builder: (context, cartViewData, child) {

          // print(cartProvider.isCartLoadedProvider);
      // Map<String, Map<String, int>> cartTempData = cartViewData.cartData;

      if (cartViewData.getCartData.isEmpty) {
        return const EmptyCart();
      }else {
        return PopScope(
          canPop: false,
          onPopInvoked: (val){
            context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
            return ;
          },
          child: Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
              },
            ),
          ),
          body: cartProvider.isCartLoadedProvider
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: dimensions.height24 / 2,
                      ),
                      //1st container with address info
                     (AppConstants.userData.address.pinCode.isNotEmpty) ?  Container(
                        height: dimensions.height40 * 2,
                        width: dimensions.screenWidth,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dimensions.height24 / 2,
                            horizontal: dimensions.width24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ReusableText(
                                        text: 'Deliver to: ',
                                        fontSize: 16,
                                        height: 0,
                                        color: Color(0xFF282828),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      ReusableText(
                                        text: AppConstants.userData.name,
                                        fontSize: 16,
                                        height: 0,
                                        color: Color(0xFF121212),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: dimensions.height8/2,
                                  // ),
                                  Flexible(
                                      child: Container(
                                    width: dimensions.width24 * 9.5,
                                    child: ReusableText(
                                      text: "${AppConstants.userData.address.houseNo}, ${AppConstants.userData.address.street}, ${AppConstants.userData.address.city}, ${AppConstants.userData.address.state}, ${AppConstants.userData.address.pinCode}",
                                      fontSize: 14,
                                      height: 0,
                                      color: Color(0xFF7A7A7A),
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('change button is tapped');
                                },
                                child: Container(
                                  width: dimensions.width65,
                                  height: dimensions.height36,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.50, color: Color(0xFFD6D6D6)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Center(
                                      child: ReusableText(
                                    text: 'Change',
                                    fontSize: 14,
                                    height: 0,
                                    color: Color(0xFF00579E),
                                    fontWeight: FontWeight.w600,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ): Container(),

                      SizedBox(
                        height: dimensions.height24 / 2,
                      ),

                      //repeated cart products
                      Column(children: _cartItems(dimensions, cartViewData)),

                      SizedBox(height: dimensions.height8 * 23.85),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          bottomNavigationBar: Container(
            height: dimensions.height8 * 9,
            width: dimensions.screenWidth,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        totalPrice.toString(),
                        style: TextStyle(
                          color: Color(0xFFB7B7B7),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '₹$salePrice',
                        style: TextStyle(
                          color: Color(0xFF121212),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // print('buy button is tapped');
                      context
                          .read<CartViewRepository>().isSingleBuyNow = false;
                      context
                          .read<CartViewRepository>()
                          .setTotalPrice(totalPrice.toInt());
                      context
                          .read<CartViewRepository>()
                          .setSalePrice(salePrice.toInt());

                      Navigator.pushNamed(context, Checkout1.route);
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
                ),
        );
      }
    });
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

  List<Widget> _cartItems(dimensions, CartViewRepository cartData) {
    List<Widget> items = [];
    totalPrice = 0;
    salePrice = 0;
    try {
      cartData.getCartData.forEach((SchoolName, productData) {
        productData.forEach((product, setData) {
          setData.forEach((set, streamData) {
            streamData.forEach((stream, quantity) {
              ProductModel productModel = cartData.products.where((element) => element.productId == product).first;
              String productName = setProductName(SchoolName, set, stream, productModel);
              int totalSalePrice = setTotalSalePrice(productModel, set, stream);
              int price = setTotalPrice(productModel, set, stream);
              totalPrice += price * quantity;
              salePrice += totalSalePrice * quantity;
              items.add(Container(
                // height: dimensions.height192,
                width: dimensions.screenWidth,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: dimensions.width24/1.5,
                    vertical: dimensions.height8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: dimensions.width83,
                                  height: dimensions.height83,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(cartData.products
                                        .where(
                                            (element) => element.productId == product)
                                        .first
                                        .image),
                                  )
                              ),
                              SizedBox(height: dimensions.height8),
                              ReusableQuantityButton(
                                quantity: quantity,
                                height: dimensions.height10*3.2,
                                width: dimensions.width10*8.3,
                                productId: product,
                                schoolName: SchoolName,
                                set: set,
                                stream: stream,
                                onChanged: (newQuantity) {
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: dimensions.height16/2,
                              ),
                              //book names
                              SizedBox(
                                width: dimensions.width120 * 2,
                                child: Text(
                                 productName,
                                  style: const TextStyle(
                                    color: Color(0xFF121212),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2, // Adjust the line height as needed
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis (...) for overflow
                                ),
                              ),

                              //stars for review
                              Row(
                                children: List.generate(
                                  5,
                                      (index) => const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Color(0xFF058FFF),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: dimensions.height32,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "${((price - totalSalePrice)/price *100).round().toString()}% off ",
                                  style: const TextStyle(
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
                      SizedBox(
                        height: dimensions.height36 / 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('Remove button pressed');
                              cartData.removeCartData(SchoolName, product , set , stream);
                              context
                                  .read<CartProvider>()
                                  .removeCartData(SchoolName, product,set , stream, context);
                              // getTotalPrice();
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
                                    ReusableText(
                                      text: 'Remove',
                                      fontSize: 14,
                                      height: 0,
                                      color: Color(0xFF7A7A7A),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Icon(
                                      Icons.delete_outline,
                                      color: Color(0xFF7A7A7A),
                                    )
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () async{
                              context
                                  .read<CartViewRepository>().isSingleBuyNow = true;
                              context
                                  .read<CartViewRepository>().setTotalPrice(price);
                              context
                                  .read<CartViewRepository>().setSalePrice(salePrice.toInt());

                              await context.read<CartViewRepository>().getCartProduct(
                                product,
                                SchoolName,
                                set,
                                stream,
                                1,);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Checkout1()),
                              );
                            },
                            child: ReusableColoredBox(
                                width: dimensions.width146,
                                height: dimensions.height36,
                                backgroundColor: Colors.transparent,
                                borderColor: Color(0xFFD6D6D6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ReusableText(
                                      text: 'Buy Now',
                                      fontSize: 14,
                                      height: 0,
                                      color: Color(0xFF7A7A7A),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xFF7A7A7A),
                                      size: 20,
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height10*2.2,
                      ),
                      const Divider(
                        height: 1.0,
                        color: Color(0xFFD6D6D6),
                      ),
                    ],
                  ),
                ),
              ));
            });
          });
        });
      });
    } catch (e) {
      print(e);
    }

    return items.isNotEmpty ? items : [Container()];
  }
}
