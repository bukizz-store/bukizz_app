import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/constants/font_family.dart';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:bukizz_1/data/repository/product_view_repository.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/buttons/cart_button.dart';
import 'package:bukizz_1/widgets/containers/Reusable_ColouredBox.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/cart_provider.dart';
import '../checkout/checkout1.dart';

List<String> text = [
  'English Book Set - Wisdom World School - Class 1st',
  'Roll Paper',
];

List<String> images = [
  'assets/school/perticular bookset/book.png',
  'assets/cart/book roll.png',
];
List<int> CartQuantity = [
  0,
  0,
];

class Pair {
  int originalPrice;
  int discountedPrice;

  Pair(this.originalPrice, this.discountedPrice);
}

List<Pair> prices = [
  Pair(2000, 1600),
  Pair(160, 80),
];

class Cart extends StatefulWidget {
  static const String route = '/cart';
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int cart_val = 2;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  double totalPrice = 0;
  double salePrice = 0;

  void getTotalPrice() {
    totalPrice = 0;
    salePrice = 0;

    var cart = context.read<CartViewRepository>();
    cart.cartData.forEach((key, value) {
      value.forEach((key, value) {
        totalPrice += cart.products
                .where((element) => element.productId == key)
                .first
                .price *
            value;
        // print(totalPrice);
      });
    });
    cart.cartData.forEach((key, value) {
      value.forEach((key, value) {
        salePrice += cart.products
                .where((element) => element.productId == key)
                .first
                .salePrice *
            value;
        print(salePrice);
      });
    });
  }

  // bool load = false;

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    print('CartUpdated');
    // var cartData = context.watch<CartViewRepository>();
    getTotalPrice();
    var cartProvider = context.watch<CartProvider>();
    return Consumer<CartViewRepository>(
        builder: (context, cartViewData, child) {
      // Map<String, Map<String, int>> cartTempData = cartViewData.cartData;

      return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: cartProvider.isCartLoadedProvider
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: dimensions.height24 / 2,
                    ),

                    //1st container with address info
                    Container(
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
                                      fontFamily: FontFamily.roboto,
                                    ),
                                    ReusableText(
                                      text: AppConstants.userData.name,
                                      fontSize: 16,
                                      height: 0,
                                      color: Color(0xFF121212),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontFamily.roboto,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height8,
                                ),
                                Flexible(
                                    child: Container(
                                      width: dimensions.width24 * 9.5,
                                      child: ReusableText(
                                                                        text: AppConstants
                                                .userData.address !=
                                            ''
                                        ? AppConstants.userData.address
                                        : '2nd floor 1884 sector 8, Sector 8, Kurukshetra, Haryana 136118',
                                                                        fontSize: 14,
                                                                        height: 0,
                                                                        color: Color(0xFF7A7A7A),
                                                                        fontWeight: FontWeight.w600,
                                                                        fontFamily: FontFamily.roboto,
                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                    )),
                              ],
                            ),
                            InkWell(
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
                    ),

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
      );
    });
  }

  List<Widget> _cartItems(dimensions, CartViewRepository cartData) {
    List<Widget> items = [];
    try {
      cartData.getCartData.forEach((SchoolName, productData) {
        productData.forEach((product, quantity) {
          items.add(Container(
            // height: dimensions.height192,
            width: dimensions.screenWidth,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dimensions.width24/2,
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
                            onChanged: (newQuantity) {
                              // setState(() {
                              //   CartQuantity[index] = newQuantity;
                              // });
                              // cartProvider.addProductInCart(
                              //     cartData
                              //         .products[index].productId,
                              //     context);
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: dimensions.height16,
                          ),

                          //book names
                          SizedBox(
                            width: dimensions.width120 * 2,
                            child: Text(
                              "${cartData.products.where((element) => element.productId == product).first.name} - ${SchoolName}",
                              style: const TextStyle(
                                color: Color(0xFF121212),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.2, // Adjust the line height as needed
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis, // Add ellipsis (...) for overflow
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
                              text: cartData.products
                                  .where(
                                      (element) => element.productId == product)
                                  .first
                                  .price
                                  .toString(),
                              style: const TextStyle(
                                color: Color(0xFFB7B7B7),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      ' ${cartData.products.where((element) => element.productId == product).first.salePrice}',
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
                      InkWell(
                        onTap: () {
                          print('Remove button pressed');
                          cartData.removeCartData(SchoolName, product );
                          context.read<CartProvider>().removeCartData(SchoolName,product);
                          getTotalPrice();
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
                        onTap: () {
                          print('Buy now button pressed');
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
                    height: dimensions.height16,
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
    } catch (e) {
      print(e);
    }

    return items.isNotEmpty ? items : [Container()];
  }
}
