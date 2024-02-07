import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/dimensions.dart';
import '../../../../../widgets/buttons/Reusable_Button.dart';

class KnowMoreScreen extends StatefulWidget {
  static const route = '/knowmore';
  const KnowMoreScreen({Key? key}) : super(key: key);

  @override
  State<KnowMoreScreen> createState() => _KnowMoreScreenState();
}

class _KnowMoreScreenState extends State<KnowMoreScreen> {
  TextEditingController messageController=TextEditingController();
  List<String> list = <String>[ 'Replace', 'Cancel','Others'];
   String ?dropdownValue ;
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact for Query'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: dimensions.height16),
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height10 * 30.9,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ReusableText(text: 'What can we help you with ? ', fontSize: 16,color: Color(0xFF121212),),
                      ReusableText(text: '* ', fontSize: 16,color:Colors.red,),
                    ],
                  ),
                  SizedBox(height: dimensions.height16,),
                  Container(
                    constraints: BoxConstraints(maxWidth: dimensions.width342,maxHeight: dimensions.height40),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF9F9F9),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFD6D6D6)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: DropdownButtonFormField(
                      items: list.map((e) {
                        return DropdownMenuItem(child: Text(e), value: e);
                      }).toList(),
                      value: dropdownValue,
                      hint: ReusableText(
                        text: 'Select Query',
                        fontSize: 14,
                        color: Color(0xFF7A7A7A),
                      ),
                      onChanged: (val) {
                        setState(() {
                          dropdownValue = val!;
                        });
                      },

                      decoration:  InputDecoration(
                        border:InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: dimensions.height8,left: dimensions.width10,right: dimensions.height10), // Adjust vertical padding
                      ),
                    ),
                  ),
                  SizedBox(height: dimensions.height16*2,),
                  ReusableText(text: 'Describe your Query ', fontSize: 16,color: Color(0xFF121212),),
                  SizedBox(height: dimensions.height10,),
                  Container(
                    width: dimensions.width16 * 21.5,
                    height: dimensions.height10*17.2,
                    child: TextField(
                      controller: messageController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        hintStyle: TextStyle(color: Color(0xFF7A7A7A)),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 0.50, color: Color(0xFFD6D6D6)),),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width10,vertical: dimensions.width24),
        child: ReusableElevatedButton(
            width: dimensions.width342,
            height: dimensions.height48,
            onPressed: (){},
            buttonText: 'Submit Query'
        ),
      ),
    );
  }
}
