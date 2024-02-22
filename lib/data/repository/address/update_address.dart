import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:flutter/foundation.dart';

class UpdateAddressRepository extends ChangeNotifier {
  Address _address = AppConstants.userData.address ?? Address(
      name: '',
      phone: '',
      houseNo: '',
      street: '',
      city: '',
      state: '',
      pinCode: '',
      email: '');


  Address get address => _address;
  set address(Address value) {
    _address = value;
    notifyListeners();
  }

  Address _alternateAddress = AppConstants.userData.alternateAddress ?? Address(
      name: '',
      phone: '',
      houseNo: '',
      street: '',
      city: '',
      state: '',
      pinCode: '',
      email: '');

  Address get alternateAddress => _alternateAddress;

  set alternateAddress(Address value) {
    _alternateAddress = value;
    notifyListeners();
  }



}
