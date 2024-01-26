import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';


class SelectLocation extends StatefulWidget {
  static const String route = '/selectlocation';
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  TextEditingController searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
        child: Column(
          children: [
            SizedBox(height: dimensions.height10*5.3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back),
                CustomTextForm(
                    width: dimensions.width10*30.9,
                    height: dimensions.height10*4.4,
                    controller: searchcontroller,
                    hintText: 'Search city',
                    icon: Icons.search,
                ),
              ],
            ),

            SizedBox(height: dimensions.height24,),

            Container(
              height: dimensions.height10*7.9,
              width: dimensions.width342,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.my_location,),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
