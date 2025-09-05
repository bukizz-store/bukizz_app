import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:bukizz/data/providers/auth/updateUserData.dart';
import 'package:bukizz/data/repository/address/update_address.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/checkout/add_address.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/address/update_address.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedAddressScreen extends StatefulWidget {
  static const String route = '/saved_address';
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: ReusableText(
          text: 'Select Address',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      body: Consumer<UpdateAddressRepository>(
        builder: (context, value, child) {
          var address =
              "${value.address.houseNo}, ${value.address.street}, ${value.address.city}, ${value.address.state}, ${value.address.pinCode}";
          var alternateAddress =
              "${value.alternateAddress.houseNo}, ${value.alternateAddress.street}, ${value.alternateAddress.city}, ${value.alternateAddress.state}, ${value.alternateAddress.pinCode}";

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: dimensions.height8 * 1.5),

                // Add New Address Button
                value.alternateAddress.pinCode.isEmpty ||
                        value.address.pinCode.isEmpty
                    ? Container(
                        width: dimensions.screenWidth,
                        height: dimensions.height48,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensions.width24),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAddress()),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.add, color: Color(0xFF00589E)),
                                ReusableText(
                                  text: 'Add New Address',
                                  fontSize: 14,
                                  color: Color(0xFF00589E),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),

                SizedBox(height: dimensions.height8 * 1.5),

                // Main Address Card
                value.address.pinCode.isNotEmpty
                    ? Container(
                        width: dimensions.screenWidth,
                        height: dimensions.height8 * 12,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dimensions.width24 / 3,
                            vertical: dimensions.height8 * 1.5,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio<String>(
                                value: address,
                                groupValue: selectedAddress,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAddress = value;
                                  });
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Deliver to: name
                                  Flexible(
                                    child: Row(
                                      children: [
                                        ReusableText(
                                          text: 'Deliver to: ',
                                          fontSize: 16,
                                          color: Color(0xFF282828),
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        ReusableText(
                                          text: context
                                              .watch<UpdateAddressRepository>()
                                              .address
                                              .name,
                                          fontSize: 16,
                                          color: Color(0xFF121212),
                                          fontWeight: FontWeight.w700,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: dimensions.height8 * 2),
                                  // Address with overflow
                                  Container(
                                    width: dimensions.width24 * 9.5,
                                    child: ReusableText(
                                      text:
                                          "${value.address.houseNo}, ${value.address.street}, ${value.address.city}, ${value.address.state}, ${value.address.pinCode}",
                                      fontSize: 14,
                                      height: 0,
                                      color: Color(0xFF7A7A7A),
                                      fontWeight: FontWeight.w600,
                                      maxLine: 2,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: dimensions.width16 / 3),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => UpdateAddress(
                                        address: context
                                            .watch<UpdateAddressRepository>()
                                            .address,
                                        keyAddress: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: dimensions.height8),
                                  child: Container(
                                    width: dimensions.width16 * 4,
                                    height: dimensions.height8 * 4.5,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 0.50,
                                            color: Color(0xFFD6D6D6)),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Center(
                                      child: ReusableText(
                                        text: 'Edit',
                                        fontSize: 14,
                                        color: Color(0xFF00579E),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),

                // Alternate Address Card
                value.alternateAddress.pinCode.isNotEmpty
                    ? Container(
                        width: dimensions.screenWidth,
                        height: dimensions.height8 * 12,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dimensions.width24 / 3,
                            vertical: dimensions.height8 * 1.5,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio<String>(
                                value: alternateAddress,
                                groupValue: selectedAddress,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAddress = value;
                                  });
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Deliver to: name
                                  Flexible(
                                    child: Row(
                                      children: [
                                        ReusableText(
                                          text: 'Deliver to: ',
                                          fontSize: 16,
                                          color: Color(0xFF282828),
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        ReusableText(
                                          text: value.alternateAddress.name,
                                          fontSize: 16,
                                          color: Color(0xFF121212),
                                          fontWeight: FontWeight.w700,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: dimensions.height8 * 2),
                                  // Address with overflow
                                  Container(
                                    width: dimensions.width24 * 9.5,
                                    child: ReusableText(
                                      text:
                                          "${value.alternateAddress.houseNo}, ${value.alternateAddress.street}, ${value.alternateAddress.city}, ${value.alternateAddress.state}, ${AppConstants.userData.alternateAddress.pinCode}",
                                      fontSize: 14,
                                      height: 0,
                                      color: Color(0xFF7A7A7A),
                                      fontWeight: FontWeight.w600,
                                      maxLine: 2,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: dimensions.width16 / 3),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => UpdateAddress(
                                        address: AppConstants
                                            .userData.alternateAddress,
                                        keyAddress: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: dimensions.height8),
                                  child: Container(
                                    width: dimensions.width16 * 4,
                                    height: dimensions.height8 * 4.5,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 0.50,
                                            color: Color(0xFFD6D6D6)),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Center(
                                      child: ReusableText(
                                        text: 'Edit',
                                        fontSize: 14,
                                        color: Color(0xFF00579E),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}
