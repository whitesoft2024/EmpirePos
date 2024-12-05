import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/colors.dart';
import '../widgets/TextInputField.dart';
import '../widgets/close_icon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          CustomerAddPage(), // Assuming CustomerAddPage is the starting point of your app
    );
  }
}

class CustomerAddPage extends StatefulWidget {
  @override
  _CustomerAddPageState createState() => _CustomerAddPageState();
}

class _CustomerAddPageState extends State<CustomerAddPage> {

  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _place = "";
  String _phoneNumber = "";
  String _pinCode = "";

  bool _isHovered = false;

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
          DateTime.now(), // Default to current date if no prior selection
      firstDate: DateTime(1900, 1, 1), // Adjust as needed for minimum date
      lastDate: DateTime.now(), // Adjust as needed for maximum date
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size =MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Add Customer"),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: _size.width * 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(), // Empty space to the left
                  ),
                  Text(
                    "Add Customer",
                    style: GoogleFonts.exo2(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CloseIcon(),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Container(
                  child: ListView(padding: EdgeInsets.all(16.0), children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextInputField(
                                width:_size.width * 0.322,
                                labelText: "First Name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a name";
                                  }
                                  return null;
                                },
                                onChanged: (value) => _name = value!,
                              ),
                              SizedBox(
                                width: _size.width * 0.0065,
                              ),
                              TextInputField(
                                width:_size.width * 0.322,
                                labelText: "Last Name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a last name";
                                  }
                                  return null;
                                },
                                onChanged: (value) => _name = value!,
                              ),
                            ],
                          ),
                          TextInputField(
                            width: _size.width * 0.651,
                            labelText: "Date of Birth",
                            readOnly:
                                true, // Make the field read-only for better UX
                            ontap: () => _selectDate(
                                context), // Trigger date picker on tap
                            validator: (value) {
                              if (_selectedDate == null) {
                                return "Please select your date of birth";
                              }
                              return null;
                            },
                            // The formatted selected date will be displayed within the TextInputField itself.
                          ),
                          TextInputField(
                            width: _size.width * 0.651,
                            labelText: "Address Name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a Address";
                              }
                              return null;
                            },
                            onChanged: (value) => _place = value!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextInputField(
                                width: _size.width * 0.322,
                                labelText: "Address Line 1",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a Line 1";
                                  }
                                  return null;
                                },
                                onChanged: (value) => _place = value!,
                              ),
                              SizedBox(width:_size.width * 0.0065,),
                              TextInputField(
                                width: _size.width * 0.322,
                                labelText: "Address Line 2",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a Line 2";
                                  }
                                  return null;
                                },
                                onChanged: (value) => _place = value!,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextInputField(
                                width: _size.width * 0.322,
                                labelText: "Town",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a Town";
                                  }
                                  return null;
                                },
                                onChanged: (value) => _place = value!,
                              ),
                              SizedBox(width: _size.width * 0.0065,),
                              TextInputField(
                                width: _size.width * 0.322,
                                labelText: "Country",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter Country";
                                  }
                                  return null;
                                },
                                onChanged: (value) => _place = value!,
                              ),
                            ],
                          ),
                          TextInputField(
                            width: _size.width * 0.651,
                            labelText: "Post Code",
                            hintText: "xxxxxx",
                            keyboardType: TextInputType.none,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a postcode";
                              }
                              if (value.length != 6) {
                                return "Pin code must be 6 digits";
                              }
                              return null;
                            },
                            onChanged: (value) => _pinCode = value!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextInputField(
                                width: _size.width * 0.322,
                                labelText: "Contact Number ",
                                hintText: "xxx-xxx-xxxx",
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    //return "Please enter a contact number ";
                                  }
                                  // Add more complex phone number validation if needed
                                  return null;
                                },
                                onChanged: (value) => _phoneNumber = value!,
                              ),
                              SizedBox(width: _size.width * 0.0065,),
                              TextInputField(
                                width: _size.width * 0.322,
                                labelText: "Contact Number 2",
                                hintText: "xxx-xxx-xxxx",
                                keyboardType: TextInputType.number,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return "Please enter a contact number 2";
                                //   }
                                //   // Add more complex phone number validation if needed
                                //   return null;
                                // },
                                onChanged: (value) => _phoneNumber = value!,
                              ),
                            ],
                          ),
                          TextInputField(
                            width: _size.width * 0.651,
                            labelText: "Email Address",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a Email Address";
                              }
                              return null;
                            },
                            onChanged: (value) => _place = value!,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //border: Border.all(width: 1),
                                  //color: Colors.transparent,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      // Process form data (e.g., save customer information)
                                      // You can navigate to another page or display a success message
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      primaryOpacity,
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.all(20.0),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                          ),
                                    ),
                                  ),
                                  child: Text(
                                    "Add  Customer",
                                    style: GoogleFonts.exo2(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: _size.width * 0.18,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
