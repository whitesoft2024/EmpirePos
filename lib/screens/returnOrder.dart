import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/colors.dart';

import '../widgets/TextInputField.dart';

class ReturnOrderDialog extends StatefulWidget {
  @override
  _ReturnOrderDialogState createState() => _ReturnOrderDialogState();
}

class _ReturnOrderDialogState extends State<ReturnOrderDialog> {
  TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Setting border radius to 10
      ),
      title: Text(
        "Return Order ",
        style: GoogleFonts.exo(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: 60,
        child: TextInputField(
          controller: discountController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          labelText: "Enter Bill No",
          //hintText: "Eg: 10",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            backgroundColor: primary,
            minimumSize: Size(80, 40),
          ),
          child: Text(
            'Cancel',
            style: GoogleFonts.exo2(color: Colors.white, fontSize: 14),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Your logic for applying the discount goes here
            String discount = discountController.text;
            // Do something with the discount value
            print("Discount applied: $discount");
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            backgroundColor: primary,
            minimumSize: Size(80, 40),
          ),
          child: Text(
            'Apply',
            style: GoogleFonts.exo2(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

void showReturnOrderDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReturnOrderDialog();
    },
  );
}
