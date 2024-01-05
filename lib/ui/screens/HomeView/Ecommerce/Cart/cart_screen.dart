import 'package:bukizz_1/ui/screens/HomeView/homeScreen.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/font_family.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../../widgets/signup_text_widget.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';

class Cart extends StatefulWidget {
  static const String route = '/cart';
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // images for list tile
  List<String> setImages = [
    'assets/cart/book roll.png',
    'assets/cart/color box.png',
    // Add more image paths as needed
  ];

  //set text
  List<String> setText = [
    'Book Roll',
    'Paint Box',
  ];

  //price will go accordingly
  List<double> setPrices = [
    80.0,
    100.0,
  ];

  //cart quantities initialised with 0
  List<int> setCartQuantities = [
    0,
    0,
  ];


  int cartQuantity=0;
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //handle back button accordingly
            Navigator.pushNamed(context, HomeScreen.route);
          },
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dimensions.width24,
              dimensions.height16,
              dimensions.width24,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1st box
                ReusableColoredBox(
                  width: dimensions.width342,
                  height: dimensions.height86,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.borderColor,

                  //two columns in a row
                  child: Padding(
                    //todo adjust according to screen size
                    padding: const EdgeInsets.only(
                        left: 10, top: 2, right: 10, bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),

                          //1st column
                          // class  school and edit button hardcoded
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //class
                              ReusableText(
                                text: 'Class 5 - Science & Math Set',
                                fontSize: 12,
                                height: 0.11,
                                fontFamily: FontFamily.roboto,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF03045E),
                              ),
                              const SizedBox(
                                height: 12,
                              ),

                              //school and its icon
                              Row(
                                children: [
                                  Icon(Icons.school_outlined),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  ReusableText(
                                    text: 'Wisdom World School',
                                    fontSize: 12,
                                    height: 0.11,
                                    fontFamily: FontFamily.roboto,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.schoolTextColor,
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 12,
                              ),

                              //edit button and its icon
                              GestureDetector(
                                child: Row(
                                  children: [
                                    ReusableText(
                                      text: 'Edit',
                                      fontSize: 12,
                                      height: 0.11,
                                      fontFamily: FontFamily.roboto,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7A7A7A),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 12,
                                    ),
                                  ],
                                ),

                                onTap: (){
                                  print('Edit button tapped');
                                },
                              )
                            ],
                          ),
                        ),

                        //2nd column with quantity increase decrease and price hardcoded
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //plus minus button
                              //functional
                              ReusableColoredBox(
                                width: dimensions.width80/1.25,
                                height: dimensions.height24,
                                backgroundColor: Colors.white,
                                borderColor: Colors.black,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        child: Icon(Icons.remove),
                                        onTap:(){
                                          setState(() {
                                            if(cartQuantity>0){
                                              cartQuantity--;
                                            }

                                          });
                                        } ,
                                    ),
                                    ReusableText(
                                        text: '$cartQuantity', fontSize: 12, height: 0.10),
                                    GestureDetector(
                                        child: Icon(Icons.add),
                                        onTap: (){
                                          setState(() {
                                            cartQuantity++;
                                          });
                                        },
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: dimensions.height16,
                              ),

                              ReusableText(
                                text: 'Rs. 1299',
                                fontSize: 12,
                                height: 0.11,
                                fontFamily: FontFamily.roboto,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF03045E),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: dimensions.height16,
                ),

                //2nd box
                //for book covers and pencil box
                ReusableColoredBox(
                  width: dimensions.width342,
                  height: dimensions.height240,
                  backgroundColor: Colors.white,
                  borderColor: Color(0xFFE8E8E8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //complete your set with -> text
                        Row(
                          children: [
                            Icon(Icons.dashboard_customize),
                            SizedBox(width: dimensions.width9),
                            ReusableText(
                              text: 'Complete your set with',
                              fontSize: 16,
                              height: 0.09,
                              fontFamily: FontFamily.roboto,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF03045E),
                            )
                          ],
                        ),
                        SizedBox(
                          height: dimensions.height16,
                        ),
                        Container(
                          height: dimensions.height172,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: dimensions.width24),
                                  child: ReusableColoredBox(
                                      width: dimensions.width169,
                                      height: dimensions.height172,
                                      backgroundColor: Colors.white,
                                      borderColor: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image container
                                          Container(
                                            width: dimensions.width169,
                                            height: dimensions.height98,
                                            child: Image(image: AssetImage(setImages[index]),),
                                          ),

                                          //book roll text hardcoded
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: dimensions.height8,
                                                left: dimensions.width24 / 2),
                                            child: ReusableText(
                                              text: setText[index],
                                              fontSize: 12,
                                              height: 0.11,
                                              fontFamily: FontFamily.roboto,
                                              fontWeight: FontWeight.w600,
                                               color:Color(0xFF03045E),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: dimensions.height8 * 2,
                                                left: dimensions.width24 / 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ReusableText(
                                                  text: '₹ ${setPrices[index]}',
                                                  fontSize: 12,
                                                  height: 0.11,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: FontFamily.roboto,
                                                  color: Color(0xFF03045E),
                                                ),

                                                //plus minus button functional
                                                ReusableColoredBox(
                                                  width: dimensions.width80/1.25,
                                                  height: dimensions.height24,
                                                  backgroundColor: Colors.white,
                                                  borderColor: Colors.black,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        child: Icon(Icons.remove),
                                                        onTap:(){
                                                          setState(() {
                                                            if(cartQuantity>0){
                                                              if (setCartQuantities[index] > 0) {
                                                                setCartQuantities[index]--;
                                                              }
                                                            }

                                                          });
                                                        } ,
                                                      ),
                                                      ReusableText(
                                                          text: '${setCartQuantities[index]}', fontSize: 12, height: 0.10),
                                                      GestureDetector(
                                                        child: Icon(Icons.add),
                                                        onTap: (){
                                                          setState(() {
                                                            setCartQuantities[index]++;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: dimensions.height16,
                ),

                //3rd box
                ReusableColoredBox(
                    width: dimensions.width342,
                    height: dimensions.height240,
                    backgroundColor: Colors.white,
                    borderColor: Color(0xFFE8E8E8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          //delivery status
                          Row(
                            children: [
                              Icon(Icons.lock_clock),
                              SizedBox(
                                width: 8,
                              ),
                              hyperText('Delivery in  ', '3-4 Days', () { })
                            ],
                          ),

                          SizedBox(
                            height: dimensions.height8 * 1.5,
                          ),

                          //horizontal line
                          Container(
                            width: 318,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFD6D6D6),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: dimensions.height8 * 2.5,
                          ),

                          //delivery address
                          Row(
                            children: [
                              Icon(Icons.location_on_sharp),
                              SizedBox(
                                width: dimensions.width24 / 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      hyperText('Delivery at  ', 'Home', () { }),
                                      SizedBox(
                                        width: dimensions.width80 * 1.4,
                                      ),
                                      Icon(Icons.chevron_right),
                                    ],
                                  ),
                                  SizedBox(
                                    height: dimensions.height8,
                                  ),

                                  //todo add overflow for address overflow prevention
                                  ReusableText(
                                    text:
                                        'Flat no. 1884, sector 8, 2nd floor, Huda Sector 8',
                                    fontSize: 12,
                                    height: 0.11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.roboto,
                                    color: Color(0xFF7A7A7A),
                                  )
                                ],
                              )
                            ],
                          ),

                          SizedBox(
                            height: dimensions.height8 * 1.5,
                          ),

                          //horizontal line
                          Container(
                            width: 318,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFD6D6D6),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: dimensions.height8 * 2.5,
                          ),

                          //name and address
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(
                                width: 8,
                              ),
                              hyperText('Aman Saini  ', '+91-7082524889', () { })

                            ],
                          ),

                          SizedBox(
                            height: dimensions.height8 * 1.5,
                          ),

                          //horizontal line
                          Container(
                            width: 318,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFD6D6D6),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: dimensions.height8 * 2.5,
                          ),

                          //total bill
                          Row(
                            children: [
                              Icon(Icons.money),
                              SizedBox(
                                width: dimensions.width24 / 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      hyperText('Total Bill ', "Rs.1555", () { }),

                                      SizedBox(
                                        width: dimensions.width80 * 1.4,
                                      ),
                                      Icon(Icons.chevron_right),
                                    ],
                                  ),
                                  SizedBox(
                                    height: dimensions.height8,
                                  ),

                                  //todo add overflow for address overflow prevention
                                  ReusableText(
                                    text: 'Incl. taxes, charges & donation',
                                    fontSize: 12,
                                    height: 0.11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.roboto,
                                    color: Color(0xFF7A7A7A),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),


      //bottom order  button
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            width: dimensions.screenWidth,
            height: 500,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //payment method
                  Container(
                    height: 47,
                    width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(image: AssetImage('assets/cart/gpay.png')),
                            ReusableText(
                              text: 'PAY USING',
                              fontSize: 10,
                              height: 0.15,
                              fontFamily: FontFamily.roboto,
                              fontWeight: FontWeight.w500,
                              color: Color(0x9903045E),
                            ),
                            GestureDetector(
                                child: Icon(Icons.arrow_drop_up),
                              onTap: (){
                                  print('arrow button tapped');
                              },

                            ),
                          ],
                        ),
                        ReusableText(
                          text: '    Google Pay UPI',
                          fontSize: 10,
                          height: 0.15,
                          fontWeight: FontWeight.w500,
                          color: Color(0x9903045E),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      print('place order button tapped');
                    },
                    child: Container(
                      height: 64,
                      width: 216,
                      decoration: ShapeDecoration(
                        color: Color(0xFF03045E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: dimensions.height16,
                            horizontal: dimensions.width16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                ReusableText(
                                  text: '₹1349',
                                  fontSize: 14,
                                  height: 0.11,
                                  fontFamily: FontFamily.roboto,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFF6FDFE),
                                ),
                                // SizedBox(height: 4,),
                                // ReusableText(text: 'TOTAL', fontSize: 12, height: 0.12,fontFamily: FontFamily.roboto,fontWeight:FontWeight.w500,color: Color(0xFFF6FDFE),)
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    ReusableText(
                                      text: 'Place Order',
                                      fontSize: 16,
                                      height: 0.09,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFF6FDFE),
                                    ),
                                    // Icon(Icons.arrow_right),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
