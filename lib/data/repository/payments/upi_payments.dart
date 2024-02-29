import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/repository/order_view_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';
import '../../../widgets/tick_screen/tick.dart';

class UPIPayment extends ChangeNotifier {
  String _transactionRefId = '';
  String _transactionNote = '';
  double _amount = 0.0;
  bool _isSubmitted = false;

  UpiIndia _upiIndia = UpiIndia();
  Future<UpiResponse>? _transaction;
  List<UpiApp> apps = [];

  String get transactionRefId => _transactionRefId;
  String get transactionNote => _transactionNote;
  double get amount => _amount;
  bool get isSubmitted => _isSubmitted;


  void setTransactionRefId(String refId) {
    _transactionRefId = refId;
    notifyListeners();
  }

  void setTransactionNote(String note) {
    _transactionNote = note;
    notifyListeners();
  }

  void setAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  void setSubmitted(bool isSubmitted) {
    _isSubmitted = isSubmitted;
    notifyListeners();
  }


  void getUPIapps() async {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      apps = value;
    }).catchError((e) {
      apps = [];
    });

    notifyListeners();
  }

  Future initiateTransaction(UpiApp app, BuildContext context) async {
    print(transactionRefId);

    await _upiIndia
        .startTransaction(
          app: app,
          receiverUpiId: "8545892770@paytm",
          receiverName: "Sugam Tripathi",
          transactionRefId: transactionRefId,
          transactionNote: transactionNote,
          amount: amount,
        )
        .then((value) => _checkTxnStatus(value.status!, context))
        .catchError((e) {
          debugPrint(e);
      AppConstants.showSnackBar(context, _upiErrorHandler(e) , AppColors.error , Icons.error);
      Navigator.of(context).pop();
    });
    notifyListeners();
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status, BuildContext context) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        context.read<OrderViewRespository>().setOrderModelData(transactionRefId , context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const TickScreen(
                    text: "Ordered Successfully",
                    secondaryText: "Your order has been placed successfully")));
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        Navigator.of(context).pop();
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        Navigator.of(context).pop();
        break;
      default:
        print('Received an Unknown transaction status');
        Navigator.of(context).pop();
    }
  }
}
