import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: const Text(
            'Notifications (1)',
           style: TextStyle(
             fontFamily: 'nunito',
             fontSize: 20,
           ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: dimensions.height16,),
          Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                          },
                          child:  Container(
                            padding: EdgeInsets.only(left: dimensions.width16,top:dimensions.height16),
                            width: dimensions.screenWidth,
                            height: dimensions.height10*13.8,
                            color: Colors.white,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Your order is',
                                      style: TextStyle(
                                        color: Color(0xFF444444),
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(width: dimensions.width10/2,),
                                    const Text(
                                      'delivered',
                                      style: TextStyle(
                                        color: Color(0xFF038B10),
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                                const Text(
                                  'On Sat: 30/03/2024',
                                  style: TextStyle(
                                    color: Color(0xFFA5A5A5),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(height: dimensions.height8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: dimensions.width10*7.2,
                                      height: dimensions.height10*7.2,
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset('assets/stationary/${index+1}.jpg')
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 240,
                                      child: Text(
                                        maxLines: 3,
                                        'Your product English Book Set - Wisdom World School - Class 1st is delivered',
                                        style: TextStyle(
                                          color: Color(0xFF444444),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w400,
                                          height: 0,

                                        ),
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),

                        ),
                        Container(
                          color: Colors.black.withOpacity(0.2),
                          width: dimensions.screenWidth,
                          height: 1,
                        )
                      ],
                    );
                  }
              )
          ),
        ],
      ),
    );
  }
}
