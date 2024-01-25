import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/buttons/Reusable_Button.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';


class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: dimensions.height8*1.5,),
              ReusableText(
                text: 'Admission Open',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF444444),
              ),
              SizedBox(height: dimensions.height8*2,),
              ReusableText(
                text: 'Fill in the details to register',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF7A7A7A),
              ),
              SizedBox(height: dimensions.height8*3,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: nameController,
                hintText:  'Full Name (Required) *',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: addressController,
                hintText:   'Email (Required) *',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:  'Address (Required) *',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              Container(
                width: dimensions.width16 * 21.5,
                height: 172,
                child: TextField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Type your message here...',
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
              ReusableElevatedButton(
                width: dimensions.width342,
                height: dimensions.height48,
                onPressed: (){},
                buttonText: 'Apply Now'
              )
            ],
          ),
        ),
      ),
    );
  }
}
