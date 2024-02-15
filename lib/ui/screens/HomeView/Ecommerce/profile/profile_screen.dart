import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/contact_us.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/orders/order.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/font_family.dart';
import '../../../../../data/providers/auth/firebase_auth.dart';
import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../main_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();

  @override
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushNamed(context, MainScreen.route);
            context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: dimensions.height16,
              color:Color(0xFFF5FAFF),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height24),
              child: Column(
                children: [
                  //order contact us
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          context.read<MyOrders>().fetchOrders();
                          Navigator.pushNamed(context, OrderScreen.route);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF00579E), ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: dimensions.width10*2)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.local_shipping,color: Color(0xFF00579E),),
                            SizedBox(width: dimensions.width10,),
                            ReusableText(
                              text: 'Your Orders',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00579E),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ContactUsScreen.route);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF00579E), ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: dimensions.width10*3)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.support_agent,color: Color(0xFF00579E),),
                            SizedBox(width: dimensions.width10,),
                            ReusableText(
                              text: 'Contact Us',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00579E),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  TextButton(onPressed: (){}, child: ReusableText(text: 'Save Changes', fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xFF00579E),)),
                  SizedBox(height: dimensions.height24/2,),
                  //address
                  Container(
                    width: dimensions.screenWidth,
                    height: dimensions.height8*12,
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: dimensions.width24/3,vertical: dimensions.height8*1.5),
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
                                      text: "${AppConstants.userData.address.houseNo}, ${AppConstants.userData.address.street}, ${AppConstants.userData.address.city}, ${AppConstants.userData.address.state}, ${AppConstants.userData.address.pinCode}",
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
                                  print('change button tapped');
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


                  SizedBox(height: dimensions.height24/3,),

                  SizedBox(height: dimensions.height24*6,),



                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height24),
        child: OutlinedButton(
          onPressed: () {
            showCustomAboutDialog(context);
          },
          style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFF00579E), ),
              ),
              padding: EdgeInsets.symmetric(horizontal: dimensions.width10*10)
          ),
          child: Row(
            children: [
              Icon(Icons.logout,color: Color(0xFF00579E),),
              SizedBox(width: dimensions.width10,),
              ReusableText(
                text: 'Log Out',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00579E),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



void showCustomAboutDialog(BuildContext context) {
  Dimensions dimensions=Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Center(
          child: Column(
            children: [
              ReusableText(text: 'Are You Sure', fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
              SizedBox(height: dimensions.height10*2,),
              ReusableText(text: 'You are about to logout from the app', fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xFF444444),),
            ],
          ),
        ),
        content:Container(
          // width: dimensions.width10*35.6,
          height: dimensions.height10*8.5,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async{
                  var authProvider = Provider.of<AuthProvider>(context, listen: false);
                  AppConstants.isLogin = false;
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLogin', false);
                  if(context.mounted)
                  {
                    authProvider.signOut(context);
                    Navigator.pushNamedAndRemoveUntil(context, SignIn.route, (route) => false);
                  }
                },
                child: Container(
                  width: dimensions.width10*11.5,
                  height: dimensions.height10*3.5,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: ReusableText(text: 'Logout', fontSize: 14,fontWeight: FontWeight.w600, color: Color(0xFF00579E),),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: dimensions.width10*11.5,
                  height: dimensions.height10*3.5,
                  decoration: ShapeDecoration(
                    color: Color(0xFF058FFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Center(
                    child: ReusableText(text: 'Cancel', fontSize: 14,fontWeight: FontWeight.w600, color:Colors.white,),
                  ),
                ),
              )
            ],
          ),
        )

      );

    },
  );
}