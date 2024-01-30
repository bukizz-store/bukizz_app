import 'package:bukizz_1/widgets/buttons/Reusable_Button.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/dimensions.dart';

class ReviewScreen extends StatefulWidget {
  static const route = '/review';
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Review Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            Container(height: dimensions.height8,color: Color(0xFFE0F0FF),),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: dimensions.width24/1.5,vertical: dimensions.height8*3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: dimensions.width10*7.6,
                        height: dimensions.height10*7.6,
                        child: SvgPicture.asset(
                          'assets/school/booksets/1.svg',
                          fit: BoxFit.cover,
                          color: Colors.red,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: dimensions.width10*25.2,
                            child: const Text(
                              'Your product English Book Set - Wisdom World School - Class 1st is delivered',
                              style: TextStyle(
                                color: Color(0xFF121212),
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: dimensions.height8/2,),
                          Row(
                            children: List.generate(
                              5,
                                  (index) => const Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xFF058FFF),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: dimensions.height8*4.2,),
                  ReusableText(text: 'Add Photo or Video (optional)', fontSize: 16,fontWeight: FontWeight.w700, color: Color(0xFF121212)),
                  SizedBox(height: dimensions.height8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
        
                        },
                        style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFF00579E), ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: dimensions.width10*3.5)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined,color: Color(0xFF00579E),),
                            ReusableText(
                              text: 'Add Photo',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00579E),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                         
                        },
                        style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFF00579E), ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: dimensions.width10*3.5)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.video_call_rounded,color: Color(0xFF00579E),),
                            ReusableText(
                              text: 'Add Video',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00579E),
                            ),
                          ],
                        ),
                      ),
        
                    ],
                  ),
                  SizedBox(height: dimensions.height8*3,),
                  ReusableText(text: 'Write a Review (optional)', fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
                  SizedBox(height: dimensions.height8*3,),
                  Container(
                    width: dimensions.width16 * 21.5,
                    height: dimensions.height10*17.2,
                    child: TextField(
                      controller: messageController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'How is the product? How was delivery experience?',
                        hintStyle: TextStyle(color: Color(0xFF7A7A7A)),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Set the text color here
                      ),
                    ),
                  ),
        
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ReusableElevatedButton(
          width: dimensions.width10*30,
          height: dimensions.height8*5,
          onPressed: (){},
          buttonText: 'Submit Reviews',
        ),
      ),
    );
  }
}
