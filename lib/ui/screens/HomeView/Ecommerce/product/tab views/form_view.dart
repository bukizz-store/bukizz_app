import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/buttons/Reusable_Button.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:bukizz/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';


class Forms extends StatefulWidget {
  static const String route = '/forms';
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
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
      appBar: AppBar(
        title: ReusableText(text: 'Admission Forms', fontSize: 18),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    text: list[0],
                    fontSize: 16,
                    color: Color(0xFF121212),
                    fontWeight: FontWeight.w700,
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
              SizedBox(height: dimensions.height8*2,),
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
                labelText: 'Full Name',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: addressController,
                hintText:   'Date of Birth (Required) *',
                labelText: 'Date of Birth',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:   'Gender (Required) *',
                labelText: 'Gender',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Aadhar No. (Required) *',
                labelText: 'Aadhar No.',
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
                labelText: 'Address',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'City (Required) *',
                labelText: 'City',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'State (Required) *',
                labelText: 'State',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Pin Code (Required) *',
                labelText: 'Pin Code',
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
                labelText: 'Father’s Name',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Mother’s name',
                labelText: 'Mother’s name',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Father’s Contact No.',
                labelText: 'Father’s Contact No.',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: emailController,
                hintText:    'Mother’s Contact No.', labelText:    'Mother’s Contact No.',
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
