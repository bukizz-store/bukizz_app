import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../data/models/user_details.dart';
import '../data/providers/bottom_nav_bar_provider.dart';
import '../data/providers/school_repository.dart';
import '../ui/screens/HomeView/Ecommerce/Cart/cart_screen.dart';

enum userType{
  student, teacher
}

enum deliveryStatus{
  Initiated , Processed , Packed , Out_For_Delivery , Delivered , Cancelled , Replacement , Not_Placed,  Canceled
}

class AppConstants{
  static late MainUserDetails userData ;
  static bool isLogin = false;
  static String location = '';
  static String fcmToken = '';

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: SpinKitChasingDots(size: 24,color: AppColors.primaryColor,),
          );
        });
  }

  static Future<void> showSnackBarTop(BuildContext context , String text , Color color , IconData icon , {int time = 2}) async {
    var snackBar = SnackBar(
      elevation: 0,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 92.h,
          left: 10,
          right: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: GestureDetector(
        onTap: (){
          context.read<BottomNavigationBarProvider>().setSelectedIndex(1);
          Navigator.pushNamed(context,  MainScreen.route);
        },
        child: Container(
          width: 270,
          height: 40,
          // padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black54,width: 2),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon ,color: Colors.white,size: 24,),
                ReusableText(text: text, fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.white,),
              ],
            ),
          ),
        ),
      ),
      duration: Duration(seconds: time),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> showSnackBar(BuildContext context , String text , Color color , IconData icon , {int time = 2}) async {
    var snackBar = SnackBar(
      elevation: 0,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 25.h,
          left: 10,
          right: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: GestureDetector(
        onTap: (){
          context.read<BottomNavigationBarProvider>().setSelectedIndex(1);
          Navigator.pushNamed(context,  MainScreen.route);
        },
        child: Container(
          width: 270,
          height: 40,
          // padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black54,width: 2),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon ,color: Colors.white,size: 24,),
                ReusableText(text: text, fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.white,),
              ],
            ),
          ),
        ),
      ),
      duration: Duration(seconds: time),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> showCartSnackBar(BuildContext context ) async {
    var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: GestureDetector(
        onTap: (){
          context.read<BottomNavigationBarProvider>().setSelectedIndex(1);
          Navigator.pushNamed(context,  MainScreen.route);
        },
        child: Container(
          width: 270,
          height: 60,
          padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFF444444),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0xFF39A7FF),
                // blurRadius: 12,
                offset: Offset(0, 5),
                // spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(text: 'Added to Cart', fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xFFF9F9F9),),
              ReusableText(text: 'Go to Cart', fontSize: 16,fontWeight: FontWeight.w700,color:Color(0xFF39A7FF),)
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}

