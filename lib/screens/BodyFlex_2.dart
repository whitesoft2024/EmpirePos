import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/colors.dart';
import 'Add_customer.dart';
import '../widgets/Calculator.dart';
import 'Delivery_address.dart';
import 'holdOrder.dart';


class BodyFlex2 extends StatefulWidget {
  @override
  _BodyFlex2State createState() => _BodyFlex2State();
}

class _BodyFlex2State extends State<BodyFlex2> {


  void _showDeliveryAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeliveryAddressDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    Widget calculatorWidget = ListView(
      shrinkWrap: true,
      children: [
        CalculatorHomePage(),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        if (_size.height < 470) calculatorWidget,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_size.height > 400)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHoldOrderContainer(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerAddPage()));
                        },
                        icon: Icons.add_reaction_outlined,
                        text: 'Add Customer',
                      ),
                      SizedBox(width: 10),
                      _buildHoldOrderContainer(
                        onTap: _showDeliveryAddressDialog,
                        icon: Icons.add_home_work_outlined,
                        text: 'Delivery Address',
                      ),
                      SizedBox(width: 10),
                      _buildHoldOrderContainer(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => holdorder()));
                        },
                        icon: Icons.file_copy_outlined,
                        text: 'Hold Order',
                      ),
                    ],
                  ),
                SizedBox(height: 10),
                if (_size.height > 400)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHoldOrderContainer(
                        onTap: () {},
                        icon: Icons.qr_code_outlined,
                        text: 'Scan Loyalty Card',
                      ),
                      SizedBox(width: 10),
                      _buildHoldOrderContainer(
                        onTap: () {},
                        icon: Icons.home,
                        text: 'Hold Order',
                      ),
                      SizedBox(width: 10),
                      _buildHoldOrderContainer(
                        onTap: () {},
                        icon: Icons.phone,
                        text: 'Hold Order',
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        if (_size.height >= 470) calculatorWidget,
        SizedBox(height: 10),
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: primaryColor,
          child: Row(
            children: [
              Text('Amount Due', style: GoogleFonts.exo2(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 15,
              )),
              Spacer(),
              Text("0", style: GoogleFonts.exo2(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHoldOrderContainer({required IconData icon, required String text, required VoidCallback onTap}) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              //border: Border.all(width: 0.1,color: Colors.black38)
            ),
            height: 110,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 25),
                  SizedBox(height: 15),
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 110),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
