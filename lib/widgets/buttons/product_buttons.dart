// import 'package:bukizz_1/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../data/repository/product_view_repository.dart';
// import '../../utils/dimensions.dart';
//
// class ProductButtons extends StatefulWidget {
//   String title;
//   int length;
//   int selectedIndex;
//   var items;
//   ProductButtons({super.key, required this.title , required this.length , required this.selectedIndex , required this.items});
//
//   @override
//   State<ProductButtons> createState() => _ProductButtonsState();
// }
//
// class _ProductButtonsState extends State<ProductButtons> {
//   @override
//   Widget build(BuildContext context) {
//     Dimensions dimensions =Dimensions(context);
//     return Container(
//       // width: double.infinity,
//       height: 200,
//       color: AppColors.white,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
//         child: Column(
//           children: [
//             Text(
//                 widget.title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                 )),
//             const SizedBox(height: 8),
//             Container(
//               height: 60,
//               child: ListView.builder(
//                 itemCount: widget.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context , index){
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     // width: 80,
//                     // height: 40,
//                     decoration: BoxDecoration(
//                       color: widget.selectedIndex == index ? AppColors.productButtonSelectedBG : AppColors.productButtonUnSelectedBG,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: widget.selectedIndex == index ? AppColors.productButtonSelectedBorder : AppColors.productButtonUnSelectedBorder,)
//                     ),
//                     child: const Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(),
//                     ),
//                   ),
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
