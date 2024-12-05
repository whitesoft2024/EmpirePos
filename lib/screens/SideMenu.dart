import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Head/user_details.dart';
import '../Style/colors.dart';
import '../Style/sizeConfig.dart';
import '../screens/returnOrder.dart';

import '../Body/bodySection.dart';
import 'LockPage.dart';
import 'order.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  IconData? selectedIcon;
  IconData? hoveredIcon;
  double iconSize = 23;
  double hoverIconSize = 26;

  void _showReturnorder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReturnOrderDialog();
      },
    );
  }

  // Method to build IconButton with dynamic parameters
  Widget buildIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    Color? color,
  }) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredIcon = icon;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredIcon = null;
        });
      },
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: hoveredIcon == icon ? hoverIconSize : iconSize,
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(hoveredIcon == icon ? primaryColor : Colors.black,),
          overlayColor: WidgetStatePropertyAll(Colors.white),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2,),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 5),
          height: MediaQuery.of(context).size.height - 57,
          width: double.infinity,
          child: Column(
            children: [
              buildIconButton(
                onPressed: _showReturnorder,
                icon: Icons.remove_shopping_cart_outlined,
                color: Colors.black,
              ),
              buildIconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => order()));
                  setState(() {
                    selectedIcon = Icons.shopping_cart_outlined;
                  });
                },
                icon: Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
              Spacer(),
              buildIconButton(
                onPressed: () {
                  setState(() {
                    selectedIcon = Icons.settings;
                  });
                },
                icon: Icons.settings,
                color: Colors.black,
              ),
              buildIconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  setState(() {
                    selectedIcon = Icons.lock_outline_rounded;
                  });
                },
                icon: Icons.lock_outline_rounded,
                color: Colors.black,
              ),
              buildIconButton(
                onPressed: () {
                  setState(() {
                    selectedIcon = Icons.logout_rounded;
                  });
                },
                icon: Icons.logout_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
