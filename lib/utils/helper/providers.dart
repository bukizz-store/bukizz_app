import 'package:bukizz/data/providers/auth/updateUserData.dart';
import 'package:bukizz/data/repository/banners/banners.dart';
import 'package:bukizz/data/repository/address/update_address.dart';
import 'package:bukizz/data/repository/category/category_repository.dart';
import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/data/repository/payments/upi_payments.dart';
import 'package:bukizz/data/repository/product/general_product.dart';
import 'package:bukizz/data/repository/retailer/retailer_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bukizz/data/providers/cart_provider.dart';
import 'package:bukizz/data/providers/header_switch.dart';
import 'package:bukizz/data/providers/product_provider.dart';
import 'package:bukizz/data/providers/school_repository.dart';
import 'package:bukizz/data/providers/stationary_provider.dart';
import 'package:bukizz/data/repository/auth_view_repository.dart';
import 'package:bukizz/data/repository/cart_view_repository.dart';
import 'package:bukizz/data/repository/product/product_view_repository.dart';
import 'package:bukizz/data/repository/user_repository.dart';
import '../../data/providers/tabController/TabController_provider.dart';
import '../../data/providers/auth/firebase_auth.dart';
import '../../data/providers/bottom_nav_bar_provider.dart';
import '../../data/repository/order_view_repository.dart';
import '../../data/repository/query/order_query.dart';
import '../../data/repository/review/product_Reviews.dart';
import '../../data/repository/review/review_repository.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(
    create: (_) => HeaderSwitchProvider(),
  ),
  ChangeNotifierProvider(create: (_) => SchoolDataProvider()),
  ChangeNotifierProvider(create: (_) => ProductProvider()),
  ChangeNotifierProvider(create: (_) => CartProvider()),
  ChangeNotifierProvider(create: (_) => UserRepositoryProvider()),
  ChangeNotifierProvider(create: (_) => ProductViewRepository()),
  ChangeNotifierProvider(create: (_) => CartViewRepository()),
  ChangeNotifierProvider(create: (_) => OrderViewRespository()),
  ChangeNotifierProvider(
    create: (_) => BottomNavigationBarProvider(),
  ),
  ChangeNotifierProvider(
    create: (_) => StationaryProvider(),
  ),
  ChangeNotifierProvider(create: (_) => AuthView()),
  ChangeNotifierProvider(create: (_) => UpdateUserData()),
  ChangeNotifierProvider(create: (_) => MyOrders()),
  ChangeNotifierProvider(create: (_) => OrderQueryRepository()),
  ChangeNotifierProvider(create: (_) => ReviewRepository()),
  ChangeNotifierProvider(create: (_) => ProductReview()),
  ChangeNotifierProvider(create: (_) => UPIPayment()),
  ChangeNotifierProvider(create: (_) => Retailer()),
  ChangeNotifierProvider(create: (_) => BannerRepository()),
  ChangeNotifierProvider(create: (_) => UpdateAddressRepository()),
  ChangeNotifierProvider(create: (_) => GeneralProductRepository()),
  ChangeNotifierProvider(create: (_) => CategoryRepository()),
  ChangeNotifierProvider(create: (_) =>TabProvider()),
];
