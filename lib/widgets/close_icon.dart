import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Style/colors.dart';

class CloseIcon extends StatefulWidget {
  CloseIcon({super.key});

  @override
  _CloseIconState createState() => _CloseIconState();
}

class _CloseIconState extends State<CloseIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      width: _size.width * 0.035,
      height: _size.height * 0.04,
      child: MouseRegion(
        onHover: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: IconButton(
          icon: Icon(Icons.close_sharp),
          color: _isHovered ? Colors.white : Colors.black, // Change color based on hover state
          hoverColor: primaryColor.withOpacity(0.7),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          iconSize: 22,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
