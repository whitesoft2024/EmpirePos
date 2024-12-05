import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Desktop/desktop_layout_page.dart';
import '../Mobile/Mobile_layout_page.dart';
import '../Tablet/Tablet_layout_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints) {
          if(constraints.maxWidth>950){

            return DesktopLayout();

          }else if(constraints.maxWidth>600){

            return TabletLayout();

          }else{

            return MobileLayout();

          }
        }

    );
  }
}
