import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/buttons/Reusable_Button.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:bukizz/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';


class Forms2 extends StatefulWidget {
  static const String route = '/forms';
  const Forms2({super.key});

  @override
  State<Forms2> createState() => _Forms2State();
}

class _Forms2State extends State<Forms2> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  List<String> list = <String>[ 'Wisdom World School', 'DAV Public School','ABC Public School'];
  String ?dropdownValue ;
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
              ReusableText(
                text: 'Admission Open',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF39A7FF),
              ),
              SizedBox(height: dimensions.height8*4,),
              ReusableText(
                text: 'Student’s Details',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF444444),
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
                hintText:   'Date of Birth (Required) *',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:   'Gender (Required) *',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Aadhar No. (Required) *',
              ),
              SizedBox(height: dimensions.height16,),
              ReusableText(
                text: 'Address',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF444444),
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Street Address (Required) *',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'City (Required) *',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'State (Required) *',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Pin Code (Required) *',
              ),
              SizedBox(height: dimensions.height16,),
              ReusableText(
                text: 'Parent’s Details',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF444444),
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Father’s Name',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Mother’s name',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Father’s Contact No.',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Mother’s Contact No.',
              ),
              SizedBox(height: dimensions.height16,),
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
