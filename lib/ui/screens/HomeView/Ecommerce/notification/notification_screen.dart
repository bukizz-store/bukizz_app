import 'dart:convert';

import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/notifications/notification_model.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/notification/empty_notification_screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/buttons/Reusable_Button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../data/repository/banners/banners.dart';
import '../../../../../data/repository/category/category_repository.dart';
import '../../../../../data/repository/my_orders.dart';
import '../../../../../data/repository/product/general_product.dart';
import '../product/Stationary/general_product_screen.dart';
import '../profile/orders/order_details.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var ref = FirebaseDatabase.instance.ref().child('notifications').child(AppConstants.userData.uid);

  @override
  Widget build(BuildContext context) {
    var banner= context.read<BannerRepository>();
    var categoryRepo = Provider.of<CategoryRepository>(context, listen: false);
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: const Text(
            'Notifications',
           style: TextStyle(
             fontFamily: 'nunito',
             fontSize: 20,
           ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: dimensions.height16,),
          Expanded(child: StreamBuilder(
            stream: ref.onValue,
            builder: (context , AsyncSnapshot<DatabaseEvent> snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(
                  child: SpinKitChasingDots(
                    color: Color(0xFF058FFF),
                    size: 24.0,
                  ),
                );
              }
              if(snapshot.data!.snapshot.children.isEmpty){
                return const EmptyNotificationScreen();
              }else{
                List<NotificationModel> notifications = [];
                notifications.clear();
                var data = snapshot.data!.snapshot.children;
                data.forEach((key) {
                  notifications.add(NotificationModel.fromJson(jsonEncode(key.value)));
                });
                return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: dimensions.width16,top:dimensions.height16),

                            width: dimensions.screenWidth,
                            height: dimensions.height10*14.8,
                            color: Colors.white,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      notifications[index].navInit,
                                      style: const TextStyle(
                                        color: Color(0xFF444444),
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(width: dimensions.width10/2,),
                                    Text(
                                      notifications[index].navLast,
                                      style: const TextStyle(
                                        color: Color(0xFF038B10),
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  notifications[index].date,
                                  style: const TextStyle(
                                    color: Color(0xFFA5A5A5),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(height: dimensions.height8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: dimensions.width10*7.2,
                                      height: dimensions.height10*7.2,
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: notifications[index].image,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          )
                                      ),
                                    ),

                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        notifications[index].content,
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Color(0xFF444444),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w400,
                                          height: 0,

                                        ),
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async{

                              if(notifications[index].link.isNotEmpty){
                                if(notifications[index].link.contains('http')||notifications[index].link.contains('https')){
                                  Uri url = Uri.parse(notifications[index].link);
                                  await launchUrl(url);
                                }
                                else if(notifications[index].link[0] == '/'){
                                  List<String> data = notifications[index].link.split('/');
                                  if(data[1] == 'category')
                                  {
                                    var selectedModel=categoryRepo.category[categoryRepo.category.indexOf(categoryRepo.category.firstWhere((element) => element.name == data[2]))];
                                    context.read<CategoryRepository>().selectedCategory = selectedModel;
                                    context.read<GeneralProductRepository>().getGeneralProductFromFirebase(selectedModel.categoryId);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   GeneralProductScreen(product: selectedModel.name)));
                                  }
                                  else if(data[1] == 'order')
                                  {
                                    var orders = context.read<MyOrders>();
                                    orders.fetchOrders().then((value) => orders.setOrder(orders.orders.indexWhere((element) => element.orderId == data[2])));
                                    Navigator.pushNamed(context, OrderDetailsScreen.route);
                                  }

                                  // context.read<TabProvider>().navigateToTab(0);
                                  // Navigator.pushNamed(context,ViewAll.route );
                                }
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: dimensions.height16,
                                  vertical: 4
                              ),
                              width: dimensions.screenWidth,
                              height: dimensions.height10 * 3.5,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(width: 0.5, color: Colors.blueGrey),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius:0.6,
                                    blurRadius: 18,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Color(0xFF7A7A7A),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Know More',
                                    style: TextStyle(
                                      color: Color(0xFF7A7A7A),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'nunito'
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey.withOpacity(0.2),
                            width: dimensions.screenWidth,
                            height: 1,
                          )
                        ],
                      );
                    }
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
