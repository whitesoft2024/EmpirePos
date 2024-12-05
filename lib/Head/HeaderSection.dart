import 'package:empirepos/Head/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/colors.dart';
import '../screens/stoke_view.dart';

class Headersection extends StatelessWidget {

  final double? mainHeight;
  final maincolor;
  final double? searchWidth;

  const Headersection({
    super.key,
    this.mainHeight=55,
    this.maincolor=Colors.white,
    this.searchWidth =400,
  });



  @override
  Widget build(BuildContext context) {
     return Container(
      color: maincolor,
      padding: EdgeInsets.only(right: 15),
      height: mainHeight,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(width: 27.5),
          Icon(Icons.menu_outlined,
              color: Colors.black87),
          SizedBox(width: 50),
          // Align(
          //   alignment: Alignment.center,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       SizedBox(height: 5), // Adjust spacing as needed
          //       Text("Ashraf's ", style: GoogleFonts.berkshireSwash(fontSize: 20)),
          //       Text(
          //         "INDIAN KITCHEN",
          //         style: GoogleFonts.dongle(fontSize: 10,letterSpacing: 1.0),
          //       ),
          //     ],
          //   ),
          // ),

          Container(
            height: 45,
              width: 100,
              decoration: BoxDecoration(
                //color: Colors.red,
                image: DecorationImage(image: AssetImage("assets/images/logo14.png",))
              ),
            ),

          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 35,
              width: searchWidth,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Baseline(
                      baseline: 17,
                      baselineType: TextBaseline.ideographic,
                      child: TextField(
                        style: GoogleFonts.exo2(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        cursorColor: Colors.black87,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: 'SEARCH',
                          hintStyle: GoogleFonts.exo2(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                     hoverColor: Colors.transparent,
                     highlightColor: Colors.transparent,
                     padding: EdgeInsets.symmetric(vertical: 2),
                     onPressed: () {},
                     icon :Icon(Icons.search_sharp,size: 20),
                     color: Colors.black87,
                  ),
                  IconButton(
                     hoverColor: Colors.transparent,
                     highlightColor: Colors.transparent,
                     padding: EdgeInsets.symmetric(vertical: 2),
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCategoryPage()));
                     },
                     icon :Icon(Icons.shopping_bag_outlined,size: 20),
                     color: Colors.black87,
                   ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20), // Adjust spacing as needed
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => user_details()));
            },
            child: Container(
              height: 35,
              width: 120,
              //color: Colors.indigoAccent.shade700,
              decoration: BoxDecoration(
                color: primaryColor,
                //border: Border.all(color: Colors.indigoAccent.shade700, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.only(left: 5, right: 3),
              child: Row(
                children: [
                  Text(
                    'USERNAME',
                    style: GoogleFonts.exo2(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.account_circle_sharp,
                      color: Colors.white),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
