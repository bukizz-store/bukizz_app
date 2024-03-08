import 'package:bukizz/data/providers/bottom_nav_bar_provider.dart';
import 'package:bukizz/data/providers/cart_provider.dart';
import 'package:bukizz/data/repository/cart_view_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/location.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/buttons/Reusable_Button.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:bukizz/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants/constants.dart';
import '../../../../../data/models/ecommerce/address/address_model.dart';
import '../../../../../data/providers/auth/updateUserData.dart';
import '../../../../../data/providers/school_repository.dart';

class SelectLocation extends StatefulWidget {
  static const String route = '/selectlocation';
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  TextEditingController searchcontroller = TextEditingController();
  // Set<String> selectedCities = Set(); // Keep track of selected cities

  List<String> cities = [
    'Kanpur',
    'Gurugram',
  ];

  String selectedCity = '';



  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    BottomNavigationBarProvider provider = context.read<BottomNavigationBarProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
          child:SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: dimensions.height40*2,),
                 SizedBox(
                  width: dimensions.width10*25.9,
                  child: const Text(
                    'Choose your city to start exploring schools near you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: dimensions.height16,),
                Container(
                  height: dimensions.screenHeight,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                       return GestureDetector(
                         onTap:(){
                           setState(() {
                             selectedCity=cities[index];
                           });
                         },
                         child: Stack(
                           children: [
                             Container(

                               width: 100.w,
                               height: 55.sp,
                               margin: EdgeInsets.only(bottom: 15),
                               clipBehavior: Clip.antiAlias,
                               decoration: BoxDecoration(

                                 boxShadow: const [
                                   BoxShadow(
                                     color: Color(0x66003B6A),
                                     blurRadius: 12,
                                     offset: Offset(0, 4),
                                     spreadRadius: 0,
                                   )
                                 ],
                                 borderRadius: BorderRadius.circular(16),
                                 border: Border.all(color: cities[index]==selectedCity?Colors.blue:Colors.transparent,width:3)
                               ),
                               child: ClipRRect(
                                   borderRadius: BorderRadius.circular(16),
                                   child: Image.asset('assets/onboarding/city${index+1}.jpeg',fit: BoxFit.cover,alignment: Alignment.topLeft, )
                               ),
                             ),

                             Positioned(
                               left: 3,
                               right: 3,
                               bottom:17.6.sp,
                               child: Container(
                                 width:91.w,
                                 height: 35.sp,
                                 decoration:  BoxDecoration(
                                     gradient: LinearGradient(
                                       begin: const Alignment(
                                           0.00, -1.00),
                                       end: Alignment(0, 0),
                                       colors: [
                                         Colors.black.withOpacity(0.1),
                                         Colors.black.withOpacity(0.75)
                                       ],
                                     ),
                                     borderRadius:
                                     BorderRadius.only(
                                         bottomLeft:
                                         Radius.circular(12),
                                         bottomRight:
                                         Radius.circular(12))
                                 ),
                               )
                             ),
                             Positioned(
                               bottom:25.sp,
                               left:32.w,
                               child: Container(
                                   width:40.w,
                                   height:12.sp,
                                   child: ReusableText(text: cities[index], fontSize: 24,fontWeight: FontWeight.w800,color: Colors.white,)
                               ),
                             ),
                           ],
                         ),
                       );
                    },

                  ),
                ),
              ],
            ),
          )
        ),

      ),
      bottomNavigationBar: selectedCity==''?null:Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.width9),
        child: ReusableElevatedButton(
            width: dimensions.width342,
            height: dimensions.height10 * 5.4,
            onPressed: () {
              context.read<CartProvider>().clearCartData();
              context.read<CartViewRepository>().cartData.clear();
              context.read<UpdateUserData>().saveLocationSetToSharedPreferences(selectedCity);
              context.read<SchoolDataProvider>().loadData(context).then((value) => debugPrint("School Data Loaded Successfully"));
              provider.setSelectedIndex(0);
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.route, (route) => false);
            },
            buttonText: 'Select Location'
        ),
      ),
    );
  }
}

// Container(
// height: dimensions.height10*48,
// child: ListView.builder(
// itemCount: 2,
// itemBuilder: (context, index) {
// final city = foundedCities[index];
// return CheckboxListTile(
// activeColor: Color(0xFF058FFF),
// // checkColor: Color(0xFF00579E),
// title: Text(city),
// value: selectedCities.contains(city),
// onChanged: (bool? value) {
// setState(() {
// if (value ?? false) {
// selectedCities.add(city);
// } else {
// selectedCities.remove(city);
// }
// });
// },
// controlAffinity: ListTileControlAffinity.leading,
// contentPadding: EdgeInsets.symmetric(
// horizontal: dimensions.width16 / 2,
// ),
// );
// },
// ),
