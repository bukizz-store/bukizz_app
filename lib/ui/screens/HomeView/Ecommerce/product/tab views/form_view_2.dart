import 'package:bukizz/constants/constants.dart';
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
  TextEditingController aadharController=TextEditingController();
  TextEditingController genderController=TextEditingController();
  TextEditingController dobController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController pinController=TextEditingController();
  TextEditingController fatherNController=TextEditingController();
  TextEditingController motherNController=TextEditingController();
  TextEditingController fatherCController=TextEditingController();
  TextEditingController motherCController=TextEditingController();
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
              SizedBox(height: dimensions.height16,),
              ReusableText(text: "Currently we are not accepting admissions!", fontSize: 16,color: Colors.red,fontWeight: FontWeight.w700,),
              //SizedBox(height: dimensions.height16*2,),
              // ReusableText(
              //   text: 'Admission Open',
              //   fontSize: 16,
              //   fontWeight: FontWeight.w700,
              //   color: Color(0xFF39A7FF),
              // ),
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
                isEmail: false,
                width: dimensions.width342,
                height: dimensions.height48,
                controller: dobController,
                hintText:   'Date of Birth (Required) *',
                labelText: 'Date of Birth',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: genderController,
                hintText:   'Gender (Required) *',
                labelText: 'Gender',
              ),
              SizedBox(height: dimensions.height8*1.5,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: aadharController,
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
                controller: addressController,
                hintText:    'Street Address (Required) *',
                labelText: 'Address',
                isEmail: true,
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: cityController,
                hintText:    'City (Required) *',
                labelText: 'City',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: stateController,
                hintText:    'State (Required) *',
                labelText: 'State',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: pinController,
                hintText:    'Pin Code (Required) *',
                labelText: 'Pin Code',
                isEmail: false,
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
                controller: fatherNController,
                hintText:    'Father’s Name',
                labelText: 'Father’s Name',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: motherNController,
                hintText:    'Mother’s name',
                labelText: 'Mother’s name',
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: fatherCController,
                hintText:    'Father’s Contact No.',
                labelText: 'Father’s Contact No.',
                isEmail: false,
              ),
              SizedBox(height: dimensions.height16,),
              CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height48,
                controller: motherCController,
                isEmail: false,
                hintText:    'Mother’s Contact No.', labelText:    'Mother’s Contact No.',
              ),
              SizedBox(height: dimensions.height16,),
              ReusableElevatedButton(
                  width: dimensions.width342,
                  height: dimensions.height48,
                  onPressed: (){
                    AppConstants.showSnackBar(context, 'Comming Soon', Colors.grey, Icons.lock_clock);
                  },
                  buttonText: 'Apply Now',
                  buttonColor: Colors.grey,
                  shadowColor: Colors.black.withOpacity(0.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
