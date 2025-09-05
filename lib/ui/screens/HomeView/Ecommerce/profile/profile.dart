import 'package:bukizz/data/providers/auth/updateUserData.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants/constants.dart';
import '../../../../../widgets/buttons/Reusable_Button.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool get _isPhoneUser {
    // User signed up with phone if email is empty or contains placeholder/default values
    return AppConstants.userData.email.isEmpty ||
        AppConstants.userData.email == '' ||
        AppConstants.userData.email ==
            'apple@email.com'; // Apple sign-in placeholder
  }

  bool get _isEmailUser {
    // User signed up with email if they have a valid email and mobile might be empty
    return AppConstants.userData.email.isNotEmpty &&
        AppConstants.userData.email != 'apple@email.com' &&
        AppConstants.userData.email.contains('@');
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = AppConstants.userData.name;
    _emailController.text = AppConstants.userData.email;
    _phoneController.text = AppConstants.userData.mobile;
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
        ),
        title: ReusableText(
          text: 'Profile',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
        child: Column(
          children: [
            SizedBox(height: dimensions.height10),
            Center(
              child: CircleAvatar(
                radius: dimensions.height10 * 5.5,
                backgroundColor: Colors.white,
                child: SvgPicture.asset('assets/user.svg'),
              ),
            ),
            SizedBox(height: dimensions.height10),
            ReusableText(
              text: AppConstants.isLogin
                  ? AppConstants.userData.name
                  : 'Guest User',
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: dimensions.height10 * 2),
            ReusableText(
              text: AppConstants.isLogin ? AppConstants.userData.email : '',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF121212).withOpacity(0.6),
            ),
            SizedBox(height: dimensions.height16),
            ReusableText(
                text: AppConstants.isLogin
                    ? AppConstants.userData.address.phone
                    : '',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF121212).withOpacity(0.6)),
            SizedBox(height: dimensions.height10 * 3),

            //full name
            Container(
              width: dimensions.width342,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name *',
                  labelStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: dimensions.height8 * 2,
                      vertical: dimensions.height16),
                ),
              ),
            ),

            SizedBox(height: dimensions.height24),
            //phone no
            Container(
              width: dimensions.width342,
              child: TextField(
                controller: _phoneController,
                enabled: !_isPhoneUser,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  labelText: _isPhoneUser
                      ? 'Phone Number * (Cannot be changed)'
                      : 'Phone Number *',
                  labelStyle: TextStyle(
                      color: _isPhoneUser
                          ? Colors.grey.withOpacity(0.4)
                          : Colors.grey.withOpacity(0.6)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                        color: _isPhoneUser
                            ? Colors.grey.withOpacity(0.3)
                            : Color(0xFF7A7A7A)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                        color: _isPhoneUser
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.black38),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: dimensions.height8 * 2,
                      vertical: dimensions.height16),
                ),
              ),
            ),
            SizedBox(height: dimensions.height24),
            //email
            Container(
              width: dimensions.width342,
              child: TextField(
                controller: _emailController,
                enabled: !_isEmailUser,
                decoration: InputDecoration(
                  labelText: _isEmailUser
                      ? 'Email Address * (Cannot be changed)'
                      : 'Email Address *',
                  labelStyle: TextStyle(
                      color: _isEmailUser
                          ? Colors.grey.withOpacity(0.4)
                          : Colors.grey.withOpacity(0.6)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                        color: _isEmailUser
                            ? Colors.grey.withOpacity(0.3)
                            : Color(0xFF7A7A7A)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                        color: _isEmailUser
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.black38),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: dimensions.height8 * 2,
                      vertical: dimensions.height16),
                ),
              ),
            ),

            // Add extra space at bottom for keyboard
            SizedBox(height: dimensions.height10 * 10),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: dimensions.width24, vertical: dimensions.height16 * 2.5),
        child: ReusableElevatedButton(
            width: dimensions.width342,
            height: dimensions.height10 * 5.4,
            onPressed: () {
              context.read<UpdateUserData>().updateUserData(
                  context, _nameController.text, _phoneController.text);
            },
            buttonText: 'Save Changes'),
      ),
    );
  }
}
