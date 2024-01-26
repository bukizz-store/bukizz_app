import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../main_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider = context.read<BottomNavigationBarProvider>();
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.route);
            provider.selectedIndex = 0;
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: dimensions.height16,
            color: Color(0xFFE0F0FF),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF00579E), ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: dimensions.width10*3)
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
                      onPressed: () {},
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
                TextField(
                  decoration:InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name *',
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
