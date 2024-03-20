import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/data/models/ecommerce/order_model.dart';
import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/data/repository/query/order_query.dart';
import 'package:bukizz/data/repository/review/review_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/add_rating.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/queryContact/contact_for_query.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../data/models/ecommerce/products/product_model.dart';
import '../../../../../../data/models/ecommerce/products/variation/set_model.dart';
import '../../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../../utils/dimensions.dart';


class OrderDetailsScreen extends StatefulWidget {
  static const route = '/orderdetails';
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double totalPrice = 0;
  double salePrice = 0;
  bool dropDown = false;
  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider =
        context.read<BottomNavigationBarProvider>();
    Dimensions dimensions = Dimensions(context);
    return Consumer<MyOrders>(builder: (context, orderData, child) {

      if(!orderData.isOrderDataLoaded){
        return const Scaffold(
          body: Center(
            child: SpinKitChasingDots(
              size: 24,
              color: AppColors.primaryColor,
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),onPressed: (){Navigator.of(context).pop();},),
          title: ReusableText(text: 'My Orders',fontSize: 20,fontWeight: FontWeight.w500,),
        ),
        body: orderData.isOrderDataLoaded? SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: dimensions.height16,
                    color:Color(0xFFF5FAFF),
                  ),
                  Column(
                    children: [
                      Container(
                        width: dimensions.screenWidth,
                        height: dimensions.height10 * 11.3,
                        padding: EdgeInsets.only(
                            left: dimensions.width16, top: dimensions.height10),
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: dimensions.width10 * 7.6,
                              height: dimensions.height10 * 7.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  dimensions.width10,
                                ),

                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    dimensions.width10,
                                  ),
                                  child: Image.asset('assets/orders.png')
                              ),
                            ),
                            SizedBox(width: dimensions.width16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: dimensions.height10,
                                ),

                                ReusableText(
                                    text:
                                    '${orderData.cartLength} items',
                                    fontSize: 12),
                                SizedBox(
                                  height: dimensions.height10,
                                ),
                                SizedBox(
                                  width: dimensions.width10 * 25.2,
                                  child: Text(
                                    'Your product ${orderData.selectedOrderModel.orderName} is ${orderData.selectedOrderModel.status}',
                                    style: const TextStyle(
                                      color: Color(0xFF444444),
                                      fontSize: 12,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: dimensions.height10,
                                ),
                                ReusableText(
                                  text:
                                  'Ordered On: ${orderData.selectedOrderModel.orderDate.substring(0, 10)}',
                                  fontSize: 12,
                                  color: Color(0xFFA5A5A5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: dimensions.screenWidth,
                          color: Colors.white,
                          child: Container(
                            child: Column(
                              children:
                              _buildWidget(orderData, context, dimensions),
                            ),
                          )),
                    ],
                  ),

                  //total amount text
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensions.width16,
                        vertical: dimensions.height16 / 2),
                    width: dimensions.screenWidth,
                    height: null,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              dropDown = !dropDown;
                            });
                          },
                          child: Row(
                            children: [
                              ReusableText(
                                text: 'Total Amount',
                                fontSize: 18,
                                color: Color(0xFF282828),
                                fontWeight: FontWeight.w500,
                              ),
                              dropDown ? Icon(Icons.arrow_drop_up) : Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        ReusableText(
                          text: '₹${salePrice + 40}',
                          fontSize: 18,
                          color: Color(0xFF121212),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              (dropDown)?
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width16,
                      vertical: dimensions.height16 / 2),
                  width: dimensions.screenWidth,
                  height: null,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //total price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: dimensions.width10 * 26.4,
                            child: Text(
                              'Price(${orderData.cartLength} items)',
                              style: const TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          ReusableText(
                            text:
                                '₹${orderData.selectedOrderModel.totalAmount}',
                            fontSize: 16,
                            color: Color(0xFF121212),
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8,
                      ),

                      //discount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Discount',
                            fontSize: 16,
                            color: Color(0xFF7A7A7A),
                            fontWeight: FontWeight.w500,
                          ),
                          ReusableText(
                              text:
                                  '-₹${orderData.selectedOrderModel.totalAmount - orderData.selectedOrderModel.saleAmount}',
                              fontSize: 16,
                              color: Color(0xFF038B10),
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2.5,
                      ),
                      //delivery charges
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Delivery Charges',
                            fontSize: 16,
                            color: Color(0xFF7A7A7A),
                            fontWeight: FontWeight.w500,
                          ),
                          ReusableText(
                            text: '₹${orderData.selectedOrderModel.deliveryCharge}',
                            fontSize: 16,
                            color: Color(0xFF121212),
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 1.5,
                      ),

                      //horizontal line
                      Container(
                        width: dimensions.screenWidth,
                        height: 1,
                        color: Color(0xFFD6D6D6),
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2.5,
                      ),

                      //total amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Total Amount',
                            fontSize: 16,
                            color: Color(0xFF282828),
                            fontWeight: FontWeight.w700,
                          ),
                          ReusableText(
                            text:
                                '₹${orderData.selectedOrderModel.saleAmount + orderData.selectedOrderModel.deliveryCharge}',
                            fontSize: 16,
                            color: Color(0xFF121212),
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),

                      SizedBox(
                        height: dimensions.height8 * 1.5,
                      ),
                      Container(
                        width: dimensions.screenWidth,
                        height: 1,
                        color: Color(0xFFD6D6D6),
                      ),
                      SizedBox(
                        height: dimensions.height8 * 1.5,
                      ),
                      ReusableText(
                        text: 'You will save ₹${orderData.selectedOrderModel.totalAmount - orderData.selectedOrderModel.saleAmount} on this order',
                        fontSize: 16,
                        color: Color(0xFF038B10),
                        fontWeight: FontWeight.w700,

                      )
                    ],
                  ),
                ) : Container(),

              SizedBox(
                height: dimensions.height24 * 2,
              ),
            ],
          ),
        ) : Center(child: SpinKitChasingDots(size: 24 ,),),
      );
    });
  }

  String setProductName(
      String school, String set, String stream, ProductModel product) {
    String streamName = product.stream.isNotEmpty
        ? "- $stream" ?? ''
        : '';
    String setName =
        product.set.isNotEmpty ? "($set)" ?? '' : '';
    return "$school - ${product.name}$streamName $setName";
  }


  int setTotalSalePrice(ProductModel product , String set , String stream){
    SetData setData = product.set.where((element) => element.name == set).first;
    int totalSalePrice = product.variation[product.set.indexOf(setData).toString()]![product.stream.isNotEmpty ? product.stream.indexOf(product.stream.where((element) => element.name == stream).first).toString() : '0']!.salePrice;
    return totalSalePrice;
  }

  int setTotalPrice(ProductModel product , String set , String stream){
    int totalPrice = product.variation[product.set.indexOf(product.set.where((element) => element.name == set).first).toString()]![product.stream.isNotEmpty ? product.stream.indexOf(product.stream.where((element) => element.name == stream).first).toString() : '0']!.price;
    return totalPrice;
  }

  List<Widget> _buildWidget(
      MyOrders orderData, BuildContext context, dimensions) {
    totalPrice = 0;
    salePrice = 0;
    // orderData.setIsOrderDataLoaded(false);
    List<Widget> list = [];

    // totalPrice = 0;
    // salePrice = 0;
    if(orderData.isOrderDataLoaded) {
      orderData.selectedOrder.forEach((schoolName, productData) {
        productData.forEach((product, setData) {
          setData.forEach((set, streamData) {
            streamData.forEach((stream, data) {
              ProductModel productModel = orderData.orderedProduct
                  .where((element) => element.productId == product)
                  .first;
              String productName =
                  setProductName(schoolName, set, stream, productModel);
              int totalSalePrice = setTotalSalePrice(productModel, set, stream);
              int price = setTotalPrice(productModel, set, stream);
              orderData.setImage = productModel.variation[productModel.set.indexOf(productModel.set.where((element) => element.name == set).first).toString()][productModel.stream.isNotEmpty? productModel.stream.indexOf(productModel.stream.where((element) => element.name == stream).first).toString() : '0'].image[0];
              totalPrice += price * data[0];
              salePrice += totalSalePrice * data[0];
              list.add(Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.height8 * 2,
                    vertical: dimensions.width10 * 1.8),
                child: Container(
                  width: dimensions.width10 * 39.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ReusableText(
                            text: 'Your order is',
                            fontSize: 16,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            width: dimensions.width10 / 2,
                          ),
                          ReusableText(
                            text: data[2],
                            fontSize: 16,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      ReusableText(
                        text:
                            '${DateTime.now().difference(DateTime.parse(orderData.selectedOrderModel.orderDate)).inDays.abs()} Day ago',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7A7A7A),
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: dimensions.width10 * 7.6,
                            height: dimensions.height10 * 7.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                dimensions.width10,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                dimensions.width10,
                              ),
                              child: Image.network(orderData.getImage)
                            ),
                          ),
                          SizedBox(
                            width: dimensions.width16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: dimensions.width10 * 25.2,
                                child: Text(
                                  'Your product $productName is ${orderData.selectedOrderModel.status}',
                                  style: TextStyle(
                                    color: Color(0xFF444444),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: dimensions.height16,
                              ),
                              ReusableText(
                                text: '₹ $salePrice',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF121212),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              //Sending Initial data to orderQuery Repository
                              context.read<OrderQueryRepository>().setInitialData(
                                orderData.selectedOrderModel.orderId,
                                productName,
                                orderData.selectedOrderModel.address.phone,
                              );
                              Navigator.pushNamed(context, KnowMoreScreen.route);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjust padding
                              side: BorderSide(color: Color(0xFF7A7A7A), width: 2), // Border color and width
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.contact_support, // Add an appropriate icon
                                  color: Color(0xFF7A7A7A),
                                ),
                                SizedBox(width: 8), // Add spacing between icon and text
                                Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF7A7A7A),
                                  ),
                                ),
                              ],
                            ),

                          ),

                          OutlinedButton(
                            onPressed: () {
                              context.read<ReviewRepository>().productName = productName;
                              context.read<ReviewRepository>().deliveryStatus = data[2];
                              context.read<ReviewRepository>().productId = product;
                              context.read<ReviewRepository>().orderId =
                                  orderData.selectedOrderModel.orderId;
                              Navigator.pushNamed(context, RatingsScreen.route);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              backgroundColor: Color(0xFF058FFF),
                              side: BorderSide(color: Color(0xFF058FFF), width: 2), // Border color and width
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12), // Adjust vertical padding
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star, // Add an appropriate icon
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8), // Add spacing between icon and text
                                  Text(
                                    'Add Review',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: dimensions.height10 * 2,
                      ),
                      Container(
                        width: dimensions.screenWidth,
                        height: 1,
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
    }
    // orderData.setIsOrderDataLoaded(true);
    return list;
  }
}
