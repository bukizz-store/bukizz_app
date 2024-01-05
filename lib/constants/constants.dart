import '../data/models/user_details.dart';

enum userType{
  student, teacher
}

enum status{
  initiated , delivered , cancelled, pending ,et
}

class AppConstants{
  static late MainUserDetails userData ;
  static bool isLogin =false;
}

