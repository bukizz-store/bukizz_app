import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/font_family.dart';
import '../../../../../data/repository/address/update_address.dart';
import '../../../../../widgets/address/update_address.dart';
import '../../../../../widgets/buttons/Reusable_Button.dart';


class AddressScreen1 extends StatefulWidget {
  static const String  route = '/address';
  const AddressScreen1({super.key});

  @override
  State<AddressScreen1> createState() => _AddressScreen1State();
}

class _AddressScreen1State extends State<AddressScreen1> {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  void initState() {
    super.initState();
    _nameController.text = AppConstants.userData.name ?? '';
    _emailController.text = AppConstants.userData.email ?? '';
    _phoneController.text = AppConstants.userData.mobile ?? '';
  }
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context); }, icon: Icon(Icons.arrow_back),),
        title: ReusableText(text:'Profile',fontSize: 16,),
      ),
      body: Column(
        children: [
          SizedBox(height: dimensions.height24,),

          //full name
          Container(
            width: dimensions.width342,
            height: dimensions.height24*2,
            child: TextField(
              controller: _nameController,
              decoration:InputDecoration(
                labelText: 'Full Name *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),
              ),
            ),
          ),

          SizedBox(height: dimensions.height24,),
          //phone no
          Container(
            width: dimensions.width342,
            height: dimensions.height24*2,
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters:[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
              decoration:InputDecoration(
                labelText: 'Phone Number *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),
              ),
            ),
          ),
          SizedBox(height: dimensions.height24,),
          //email
          Container(
            width: dimensions.width342,
            height: dimensions.height24*2,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration:InputDecoration(
                labelText: 'Email Address *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: dimensions.height8 * 2),
              ),
            ),
          ),
          SizedBox(height: dimensions.height24/3,),
          // TextButton(onPressed: (){
          //
          // }, child: ReusableText(text: 'Save Changes', fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xFF00579E),)),
          SizedBox(height: dimensions.height24/2,),
          //address
          Container(
            width: dimensions.screenWidth,
            height: dimensions.height8*12,
            // color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width16,vertical: dimensions.height8*1.5),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Address
                          ReusableText(text: 'Address', fontSize: 16),

                          SizedBox(height: dimensions.height8*2,),
                          // address with overflow
                          Container(
                            width: dimensions.width24 * 9.5,
                            child: ReusableText(
                              text: "${context.watch<UpdateAddressRepository>().address.houseNo}, ${context.watch<UpdateAddressRepository>().address.street}, ${context.watch<UpdateAddressRepository>().address.city}, ${context.watch<UpdateAddressRepository>().address.state}, ${context.watch<UpdateAddressRepository>().address.pinCode}",
                              fontSize: 14,
                              height: 0,
                              color: Color(0xFF7A7A7A),
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.nunito,
                              overflow: TextOverflow.ellipsis,
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
                            child: Center(child: ReusableText(text: 'Edit', fontSize: 14,color: Color(0xFF00579E),fontWeight: FontWeight.w600,),),
                          ),
                        ),
                      ),
                    ]
                )
            ),
          ),


        ],
      ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.width9),
          child: ReusableElevatedButton(
              width: dimensions.width342,
              height: dimensions.height10 * 5.4,
              onPressed: () {

              },
              buttonText: 'Save Changes'
          ),
        ),
    );
  }
}
