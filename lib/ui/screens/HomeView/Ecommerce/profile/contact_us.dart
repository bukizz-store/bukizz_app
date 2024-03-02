import 'dart:math';

import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreen extends StatelessWidget {
  static const route = '/contact_us';

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),onPressed: (){Navigator.of(context).pop();},),
        title: ReusableText(text: 'Contact Us',fontSize: 20,fontWeight: FontWeight.w500,),
      ),
      body: Column(
        children: [
          SizedBox(height: dimensions.height16,),
          Container(
            width: dimensions.screenWidth,
            // height: dimensions.height10*16.6,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: dimensions.width16),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0,-1),
                    spreadRadius: 1
                  )
                ],
                color: Colors.white,
              borderRadius: BorderRadius.circular(24)
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: dimensions.height10,),
                ReusableText(text: 'Customer Support', fontSize: 18,color: Colors.black87,fontWeight: FontWeight.w500,),
                SizedBox(height: dimensions.height32,),
                GestureDetector(
                  onTap: ()async{
                    Uri phoneno = Uri.parse('tel:+919369467134');
                    await launchUrl(phoneno);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(

                        child: Icon(Icons.phone_outlined,color: Colors.black38,),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: 'Contact Number', fontSize: 14,color: Colors.grey,),
                          SizedBox(height: dimensions.height16,),
                          ReusableText(text: '+(91) 9369467134', fontSize: 15,fontWeight: FontWeight.w500,)

                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(height: dimensions.height8 * 3),
                GestureDetector(
                  onTap: ()async{
                    Uri email = Uri.parse('mailto:<bukizzstore@gmail.com>');
                    await launchUrl(email);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(

                        child: Icon(Icons.email_outlined,color: Colors.black38,),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: 'Email Address', fontSize: 14,color: Colors.grey,),
                          SizedBox(height: dimensions.height16,),
                          ReusableText(text: 'bukizzstore@gmail.com', fontSize: 16,fontWeight: FontWeight.w500,)

                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: dimensions.height32,),

          Container(
            width: dimensions.screenWidth,
            // height: dimensions.height10*24,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: dimensions.width16),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 12,
                      offset: Offset(0,-1),
                      spreadRadius: 1
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(24)
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: dimensions.height10,),
                ReusableText(text: 'Social Media', fontSize: 18,color: Colors.black87,fontWeight: FontWeight.w500,),
                SizedBox(height: dimensions.height32,),
                GestureDetector(
                  onTap: ()async{
                    Uri url = Uri.parse('https://www.instagram.com/bukizz_store?igsh=MzRlODBiNWFlZA==');
                    await launchUrl(url);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(

                        child:  FaIcon(
                          FontAwesomeIcons.instagram,
                        ),
                        backgroundColor: Colors.pink,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: 'Instagram', fontSize: 14,color: Colors.grey,),
                          SizedBox(height: dimensions.height16,),
                          ReusableText(text: 'bukizz_store', fontSize: 15,fontWeight: FontWeight.w500,)

                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(height: dimensions.height8 * 3),
                GestureDetector(
                  onTap: ()async{
                    Uri email = Uri.parse('https://bukizz.com/');
                    await launchUrl(email);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(

                        child: FaIcon(
                          FontAwesomeIcons.chrome
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: 'Website', fontSize: 14,color: Colors.grey,),
                          SizedBox(height: dimensions.height16,),
                          ReusableText(text: 'bukizz.com', fontSize: 16,fontWeight: FontWeight.w500,)

                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: dimensions.height24,),
                GestureDetector(
                  onTap: ()async{
                    Uri phoneno = Uri.parse('https://www.linkedin.com/in/sanyam09?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app');
                    await launchUrl(phoneno);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(

                        child:  FaIcon(
                          FontAwesomeIcons.linkedin,
                        ),
                        backgroundColor: Colors.indigo,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: 'LinkedIn', fontSize: 14,color: Colors.grey,),
                          SizedBox(height: dimensions.height16,),
                          ReusableText(text: 'bukizz_store', fontSize: 15,fontWeight: FontWeight.w500,)

                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }


}
