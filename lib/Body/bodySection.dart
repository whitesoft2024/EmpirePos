// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:restorentapp/screens/RecommendItems.dart';
// import '../screens/BodyFlex_2.dart';
// import '../screens/ItemList.dart';
// import '../screens/SideMenu.dart';
//
// class Bodysection extends StatefulWidget {
//   const Bodysection({super.key});
//
//   @override
//   State<Bodysection> createState() => _BodysectionState();
// }
//
// class _BodysectionState extends State<Bodysection> {
//   int yourQuantityValue = 0;
//   int yourDiscountValue = 0;
//   int yourPriceValue = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//       Expanded(
//           flex: 1,
//           child: MenuItems()),
//       SizedBox(width: 10,),
//       Expanded(
//         flex: 5,
//         child: BodyFlex2(),
//       ),
//       SizedBox(width: 10,),
//           Expanded(
//             flex: 8,
//             child: BodyFlex3(
//               quantity: yourQuantityValue,
//               discount: yourDiscountValue,
//               price: yourPriceValue,
//             ),
//           ),
//
//           SizedBox(width: 10),
//       Expanded(
//         flex: 5,
//         child: BodyFlex4(),
//       ),
//           SizedBox(width: 10,)
//     ]);
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:restorentapp/Body/BodyFlex_2.dart';
// // import 'package:restorentapp/Body/ItemList.dart';
// // import 'package:restorentapp/Head/user_details.dart';
// // import '../Responsive/Responsive_layout.dart';
// // import 'RecommendItems.dart';
// // import 'SideMenu.dart';
// //
// // class Bodysection extends StatelessWidget {
// //   int yourQuantityValue = 0;
// //   int yourDiscountValue = 0;
// //   int yourPriceValue = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // It provide us the width and height
// //     Size _size = MediaQuery.of(context).size;
// //     return Scaffold(
// //       body: Responsive(
// //         // Let's work on our mobile part
// //         mobile: user_details(), //ListOfEmails(),
// //         tablet: Row(
// //           children: [
// //             Expanded(
// //               // flex: 1,
// //               child: MenuItems(),
// //               //ListOfEmails(),
// //             ),
// //             Expanded(
// //               flex: 6,
// //               child: BodyFlex2(),
// //               //ListOfEmails(),
// //             ),
// //             Expanded(
// //               flex: 9,
// //               child: BodyFlex3(
// //                 quantity: yourQuantityValue,
// //                 discount: yourDiscountValue,
// //                 price: yourPriceValue,
// //               ),
// //             ),
// //           ],
// //         ),
// //         desktop: Row(
// //           children: [
// //             // Once our width is less then 1300 then it start showing errors
// //             // Now there is no error if our width is less then 1340
// //             Expanded(
// //               flex: _size.width > 1340 ? 1 : 2,
// //               child: MenuItems(),
// //             ),
// //             SizedBox(width: 10,),
// //             Expanded(
// //               flex: _size.width > 1340 ? 5 : 8,
// //               child: BodyFlex2(),
// //             ),
// //             SizedBox(width: 10,),
// //             Expanded(
// //               flex: _size.width > 1340 ? 8 : 12,
// //               child: BodyFlex3(
// //                 quantity: yourQuantityValue,
// //                 discount: yourDiscountValue,
// //                 price: yourPriceValue,
// //               ),
// //             ),
// //             SizedBox(width: 10,),
// //             Expanded(
// //               flex: _size.width > 1340 ? 5 : 8,
// //               child: BodyFlex4(),
// //             ),
// //             SizedBox(width: 10,),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
