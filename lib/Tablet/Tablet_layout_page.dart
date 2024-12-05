import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Head/HeaderSection.dart';
import '../screens/BodyFlex_2.dart';
import '../screens/ItemList.dart';
import '../screens/RecommendItems.dart';
import '../screens/SideMenu.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  int yourQuantityValue = 0;
  int yourDiscountValue = 0;
  int yourPriceValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Headersection(mainHeight: 55,searchWidth: 250,),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: MenuItems()),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: BodyFlex2(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: BodyFlex3(),
                    ),
                    SizedBox(width: 10),
                    // Expanded(
                    //   flex: 5,
                    //   child: BodyFlex4(),
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
