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

import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../data/repository/banners/banners.dart';
import '../../../../../data/repository/category/category_repository.dart';
import '../../../../../data/repository/my_orders.dart';
import '../../../../../data/repository/product/general_product.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import '../product/Stationary/general_product_screen.dart';
import '../profile/orders/order_details.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  @override
  Widget build(BuildContext context) {
    if(AppConstants.isLogin) {
      // var ref = FirebaseDatabase.instance.ref().child('notifications').child(AppConstants.userData.uid);
      // var banner= context.read<BannerRepository>();
      // var categoryRepo = Provider.of<CategoryRepository>(context, listen: false);
      Dimensions dimensions=Dimensions(context);
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
        },
        child: Scaffold(
          appBar: AppBar(
            title: ReusableText(text: 'Notifications',fontSize: 20,fontWeight: FontWeight.w500,),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
              onPressed: () {
                context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
              },
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: dimensions.height16,),
              const Expanded(child: EmptyNotificationScreen())
              // Expanded(child: StreamBuilder( ... commented out code ... ))
            ],
          ),
        ),
      );
    }else{
      return Scaffold(
        body: const EmptyNotificationScreen(),
      );
    }

  }
}
