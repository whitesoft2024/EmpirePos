import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/colors.dart';
import '../widgets/TextInputField.dart';

class DeliveryAddressDialog extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 700,  // Adjust the width as needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              leading: Row(
                children: [
                  SizedBox(width: 16,),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              centerTitle: true,
              title: Text(
                'Add Delivery Details',
                style: GoogleFonts.exo2(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  TextInputField(
                    width: double.infinity,
                    labelText: "Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter  name";
                      }
                      return null;
                    },
                    onChanged: (value) => {},
                  ),
                  TextInputField(
                    controller: addressController,
                    labelText: "Address",
                    hintText: "Enter Address",
                    width: double.infinity,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextInputField(
                        width: 320,
                        labelText: "Address Line 1",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Line 1";
                          }
                          return null;
                        },
                        onChanged: (value) => {},
                      ),
                      SizedBox(width: 10),
                      TextInputField(
                        width: 320,
                        labelText: "Address Line 2",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Line 2";
                          }
                          return null;
                        },
                        onChanged: (value) => {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextInputField(
                        width: 320,
                        labelText: "Town",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Town";
                          }
                          return null;
                        },
                        onChanged: (value) => {},
                      ),
                      SizedBox(width: 10),
                      TextInputField(
                        width: 320,
                        labelText: "Country",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Country";
                          }
                          return null;
                        },
                        onChanged: (value) => {},
                      ),
                    ],
                  ),
                  TextInputField(
                    controller: postalCodeController,
                    labelText: "Postal Code",
                    hintText: "Enter Postal Code",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    width: double.infinity,
                  ),
                  TextInputField(
                    width:double.infinity,
                    labelText: "Contact Number ",
                    hintText: "xxx-xxx-xxxx",
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a contact number ";
                      }
                      // Add more complex phone number validation if needed
                      return null;
                    },
                    onChanged: (value) => {},
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(4)),
                          ),
                          backgroundColor: primaryOpacity,
                          minimumSize: Size(100, 45),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.exo2(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(4)),
                          ),
                          backgroundColor: primaryOpacity,
                          minimumSize: Size(100, 45),
                        ),
                        child: Text(
                          'Save',
                          style: GoogleFonts.exo2(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
