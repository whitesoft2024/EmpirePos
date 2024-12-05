import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Head/HeaderSection.dart';
import '../screens/BodyFlex_2.dart';
import '../screens/ItemList.dart';
import '../screens/RecommendItems.dart';
import '../screens/SideMenu.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int yourQuantityValue = 0;
  int yourDiscountValue = 0;
  int yourPriceValue = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Headersection(mainHeight: 55),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: size.width > 1340 ? 1 : 2,
                        child: MenuItems()
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: size.width > 1340 ? 5 : 8,
                      child: BodyFlex2(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: size.width > 1340 ? 8 : 12,
                      child: BodyFlex3(
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: size.width > 1340 ? 5 : 8,
                      child: BodyFlex4(),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
