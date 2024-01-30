import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/checkout/add_address.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/checkout/checkout2.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../widgets/circle/custom circleAvatar.dart';


class Checkout1 extends StatefulWidget {
  static const route = '/checkout1';
  const Checkout1({super.key});

  @override
  State<Checkout1> createState() => _Checkout1State();
}

class _Checkout1State extends State<Checkout1> {
  String? selectedAddress;
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Delivery Address'),
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
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24*1.5),
                child: Row(
                  children: [
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black38,
                      borderWidth: 0.10,
                      child: ReusableText(text: '1', fontSize: 16,color: Colors.white, height: null,),
                    ),
                    Container(
                      width: 90.0,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Colors.transparent,
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '2', fontSize: 16,color: Color(0xFF058FFF),),
                    ),
                    Container(
                      width: 90.0,
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
            ),

            SizedBox(height: dimensions.height8*1.5,),
            //add new address
            Container(
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
                      Icon(Icons.add,color:Color(0xFF00589E),),
                      ReusableText(text: 'Add New Address', fontSize: 14,color: Color(0xFF00589E),)
                    ],
                  ),
                ),
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
                      value: "${AppConstants.userData.address.houseNo}, ${AppConstants.userData.address.street}, ${AppConstants.userData.address.city}, ${AppConstants.userData.address.state}, ${AppConstants.userData.address.pinCode}",
                      groupValue: selectedAddress,
                      onChanged: (value) {
                        setState(() {
                          selectedAddress = value;
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
                            text: "${AppConstants.userData.address.houseNo}, ${AppConstants.userData.address.street}, ${AppConstants.userData.address.city}, ${AppConstants.userData.address.state}, ${AppConstants.userData.address.pinCode}",
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Checkout2()),
            );
          }
        },
        child: Container(
          height: dimensions.height8 * 9,
          width: dimensions.screenWidth,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height8*1.5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xFF058FFF),

              ),
              child: Center(child: ReusableText(text: 'Deliver Here',fontSize:16,fontWeight: FontWeight.w700,color: Colors.white,)),
            )
          ),
        ),
      ),
    );
  }
}
