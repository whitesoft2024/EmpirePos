import 'package:flutter/cupertino.dart';

class Sizeconfig{
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizondal;
  static double? blockSizeVertical;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth  = _mediaQueryData?.size.width;
    screenHeight  = _mediaQueryData?.size.height;
    blockSizeHorizondal = screenWidth! /100;
    blockSizeVertical = screenHeight! /100;
  }
}