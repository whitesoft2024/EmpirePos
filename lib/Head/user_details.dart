import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class user_details extends StatelessWidget {
  const user_details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Text("Murshid"),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class BodyFlex3 extends StatelessWidget {
//   final List<Map<String, String>>? items;
//
//   BodyFlex3({Key? key,  this.items, }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Calculate total price and total discount
//     int totalPrice = 0;
//     int totalDiscount = 0;
//     items?.forEach((item) {
//       totalPrice += int.parse(item["price"]!);
//       totalDiscount += int.parse(item["discount"]!);
//     });
//
//     return Column(
//       children: [
//         SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           height: 585,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
//             color: Colors.white,
//             image: DecorationImage(
//               scale: 1.7,
//               opacity: 0.3,
//               image: AssetImage("assets/images/Whitesoft3.png"),
//               fit: BoxFit.scaleDown,
//             ),
//           ),
//           child: ListView(
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             children: items!.map((item) {
//               return Column(
//                 children: [
//                   _builditemList(item["price"]!, item["discount"]!),
//                   SizedBox(height: 10),
//                 ],
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(height: 2),
//         Container(
//           height: 80,
//           color: Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           child: Column(
//             children: [
//               _buildRow("LINES", "${items?.length}", "SUBTOTAL", "$totalPrice"),
//               _buildRow("DISCOUNT", "$totalDiscount", "CGST", "0"),
//               _buildRow("ROUND OFF", "0", "SGST", "0"),
//             ],
//           ),
//         ),
//         Container(
//           height: 60,
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ButtonStyle(
//               backgroundColor:
//               MaterialStateProperty.all<Color>(Colors.indigoAccent.shade700!),
//               padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                   EdgeInsets.all(20.0)),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   //borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             child: Text(
//               'Payment',
//               style: GoogleFonts.exo2(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w800,
//                 fontSize: 17,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildRow(String title, String value, String title1, String value1) {
//     return Row(
//       children: [
//         Container(
//           height: 20,
//           width: 265,
//           child: Row(
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.exo2(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 value,
//                 style: GoogleFonts.exo2(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: 50),
//         Container(
//           height: 20,
//           width: 274,
//           child: Row(
//             children: [
//               Text(
//                 title1,
//                 style: GoogleFonts.exo2(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 value1,
//                 style: GoogleFonts.exo2(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _builditemList(String itemPrice, String itemDisc) {
//     return Container(
//       //padding: EdgeInsets.all(10),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(color: Colors.black87, width: 1.5),
//       ),
//       height: 60,
//       child: Row(
//         children: [
//           SizedBox(width: 10),
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(30),
//                 border: Border.all(color: Colors.black87, width: 2)),
//             child: Center(
//               child: Text(
//                 "1",
//                 style: GoogleFonts.exo2(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//           SizedBox(width: 10),
//           Text(
//             "Name",
//             style: GoogleFonts.exo2(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Spacer(),
//           Container(
//             height: 45,
//             width: 100,
//             child: Column(
//               children: [
//                 Text(
//                   "Price : $itemPrice",
//                   style: GoogleFonts.exo2(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 15,
//                   ),
//                 ),
//                 Text(
//                   "Disc  : $itemDisc",
//                   style: GoogleFonts.exo2(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 15,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
