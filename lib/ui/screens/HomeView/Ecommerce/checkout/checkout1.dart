import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/repository/address/update_address.dart';
import 'package:bukizz/data/repository/order_view_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/checkout/add_address.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/checkout/checkout2.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../data/providers/auth/updateUserData.dart';
import '../../../../../data/providers/school_repository.dart';
import '../../../../../widgets/address/update_address.dart';
import '../../../../../widgets/circle/custom circleAvatar.dart';


class Checkout1 extends StatefulWidget {
  static const String  route = '/checkout1';
  const Checkout1({super.key});

  @override
  State<Checkout1> createState() => _Checkout1State();
}

class _Checkout1State extends State<Checkout1> {
  String? selectedAddress;
  Future<void> checkDeliverable() async {
    print(AppConstants.location);

    await FirebaseDatabase.instance
        .ref()
        .child('pincode')
        .child(AppConstants.location)
        .get()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        if (snapshot.value.toString().contains(context.read<OrderViewRespository>().getUserAddress.pinCode)) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Checkout2()),
          );
        } else {
          AppConstants.showSnackBarTop(context , 'Delivery unavailable here' , AppColors.error , Icons.error_outline_rounded);
          print('Delivery unavailable at this location');
        }
      } else {
        AppConstants.showSnackBarTop(context, 'Delivery unavailable here', AppColors.error, Icons.error_outline_rounded);
        print('Delivery unavailable at this location');
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);

    return Consumer<UpdateAddressRepository>(builder:  (context , value, child){
      var address = "${value.address.houseNo}, ${value.address.street}, ${value.address.city}, ${value.address.state}, ${value.address.pinCode}";
      var alternateAddress = "${value.alternateAddress.houseNo}, ${value.alternateAddress.street}, ${value.alternateAddress.city}, ${value.alternateAddress.state}, ${value.alternateAddress.pinCode}";
      return Scaffold(
        appBar: AppBar(
          title: const Text('Select Delivery Address'),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black,
                      borderWidth: 0.50,
                      fontWeight: FontWeight.w700,
                      child: ReusableText(text: '1', fontSize: 16,color: Colors.white, height: null,),
                    ),
                    Container(
                      width: 18.w,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Colors.transparent,
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      text: 'Summary',
                      child: ReusableText(text: '2', fontSize: 16,color: Color(0xFF058FFF),),
                    ),
                    Container(
                      width: 18.w,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Colors.transparent,
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      text: 'Payment',
                      child: ReusableText(text: '3', fontSize: 16,color: Color(0xFF058FFF),),
                    ),
                  ],
                ),
              ),

              SizedBox(height: dimensions.height8*1.5,),
              //add new address
              value.alternateAddress.pinCode.isEmpty || value.address.pinCode.isEmpty ?  Container(
                width: dimensions.screenWidth,
                height: dimensions.height48,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddAddress()),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add,color:Color(0xFF00589E),),
                        ReusableText(text: 'Add New Address', fontSize: 14,color: Color(0xFF00589E),)
                      ],
                    ),
                  ),
                ),
              ): Container(),

              SizedBox(height: dimensions.height8*1.5,),

              //address selection
              value.address.pinCode.isNotEmpty ? Container(
                width: dimensions.screenWidth,
                height: dimensions.height8*12,
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: dimensions.width24/3,vertical: dimensions.height8*1.5),
                    child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: address,
                            groupValue: selectedAddress,
                            onChanged: (value) {
                              setState(() {
                                selectedAddress = value;
                                context.read<OrderViewRespository>().setUserAddress(context.read<UpdateAddressRepository>().address);
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
                                    ReusableText(text: context.watch<UpdateAddressRepository>().address.name, fontSize: 16,color:Color(0xFF121212),fontWeight: FontWeight.w700,overflow: TextOverflow.clip,),
                                  ],
                                ),
                              ),

                              SizedBox(height: dimensions.height8*2,),
                              // address with overflow
                              Container(
                                width: dimensions.width24 * 9.5,
                                child: ReusableText(
                                  text: "${value.address.houseNo}, ${value.address.street}, ${value.address.city}, ${value.address.state}, ${value.address.pinCode}",
                                  fontSize: 14,
                                  height: 0,
                                  color: Color(0xFF7A7A7A),
                                  fontWeight: FontWeight.w600,
                                  // overflow: TextOverflow.ellipsis,
                                  maxLine: 2,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: dimensions.width16/3,),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpdateAddress(address: context.watch<UpdateAddressRepository>().address , keyAddress: true,)));
                            },
                            child: Padding(
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
                          ),
                        ]
                    )
                ),
              ) : Container(),
              value.alternateAddress.pinCode.isNotEmpty ?  Container(
                width: dimensions.screenWidth,
                height: dimensions.height8*12,
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: dimensions.width24/3,vertical: dimensions.height8*1.5),
                    child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: alternateAddress,
                            groupValue: selectedAddress,
                            onChanged: (value) {
                              setState(() {
                                selectedAddress = value;
                                context.read<OrderViewRespository>().setUserAddress(context.read<UpdateAddressRepository>().alternateAddress);
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
                                    ReusableText(text: value.alternateAddress.name, fontSize: 16,color:Color(0xFF121212),fontWeight: FontWeight.w700,overflow: TextOverflow.clip,),
                                  ],
                                ),
                              ),

                              SizedBox(height: dimensions.height8*2,),
                              // address with overflow
                              Container(
                                width: dimensions.width24 * 9.5,
                                child: ReusableText(
                                  text: "${value.alternateAddress.houseNo}, ${value.alternateAddress.street}, ${value.alternateAddress.city}, ${value.alternateAddress.state}, ${AppConstants.userData.alternateAddress.pinCode}",
                                  fontSize: 14,
                                  height: 0,
                                  color: Color(0xFF7A7A7A),
                                  fontWeight: FontWeight.w600,
                                  maxLine: 2,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: dimensions.width16/3,),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpdateAddress(address:AppConstants.userData.alternateAddress , keyAddress: false,)));
                            },
                            child: Padding(
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
                          ),
                        ]
                    )
                ),
              ) : Container(),
            ],
          ),
        ),

        bottomNavigationBar: InkWell(
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
              checkDeliverable();
            }
          },
          child: Container(
            height: dimensions.height8 * 9,
            width: dimensions.screenWidth,

            // color: Colors.white,
            child: Padding(
                padding: EdgeInsets.only(bottom: dimensions.width24,left: dimensions.width24,right: dimensions.width24),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.productButtonSelectedBorder,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          color:Color(0xFF0466b5),
                          offset:Offset(0,4),

                        )
                      ]
                  ),
                  child: Center(child: ReusableText(text: 'Deliver Here',fontSize:16,fontWeight: FontWeight.w700,color: Colors.white,)),
                )
            ),
          ),
        ),
      );

    },);

  }

}
