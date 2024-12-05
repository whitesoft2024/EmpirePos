import 'dart:io';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/colors.dart';
import '../widgets/TextInputField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _discountController = TextEditingController();
  double _totalAmount = 15;
  double _discountAmount = 0;
  double _taxAmount = 0;
  double _grandTotal = 15;

  int _amount = 15;
  int _paidAmount = 0;

  // State variables for balance and points
  String _balanceAmount = '';
  String _pointsEarned = '';

  @override
  void initState() {
    super.initState();
    fetchBalanceAndPoints();
  }

  Future<void> fetchBalanceAndPoints() async {
    // Simulating a backend fetch with a delay
    await Future.delayed(Duration(seconds: 2));

    // Fetch the balance and points from backend
    setState(() {
      _balanceAmount = '500'; // Replace with actual backend data
      _pointsEarned = '50'; // Replace with actual backend data
    });
  }

  File? _pickedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'pdf','svg'], // Example allowed extensions
    );

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  void _applyDiscountInRupees() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController discountController = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Setting border radius to 5
          ),
          title: Text("Discount Amount",
            style: GoogleFonts.exo(
                color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 60,
            child: TextInputField(
              controller: discountController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,],
              labelText: "Enter Discount Amount",
              hintText: "Eg : 10",
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(4)),
                ),
                backgroundColor: Colors.brown,
                minimumSize: Size(80, 40),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.exo2(
                    color: Colors.white, fontSize: 14),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _discountAmount = double.parse(discountController.text);
                  _grandTotal = _totalAmount - _discountAmount + _taxAmount;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(4)),
                ),
                backgroundColor: Colors.brown,
                minimumSize: Size(80, 40),
              ),
              child: Text(
                'Apply',
                style: GoogleFonts.exo2(
                    color: Colors.white, fontSize: 14),
              ),
            ),

          ],
        );
      },
    );
  }

  void _applyDiscountInPercentage() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController discountController = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Setting border radius to 5
          ),
          backgroundColor: Colors.white,
          title: Text("Discount Percentage",
            style: GoogleFonts.exo(
                color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 60,
            child: TextInputField(
              controller: discountController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),],
              labelText: "Enter Discount Percentage",
              hintText: "Eg : 10",
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(4)),
                ),
                backgroundColor: Colors.brown,
                minimumSize: Size(80, 40),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.exo2(
                    color: Colors.white, fontSize: 14),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double discountPercentage = double.parse(discountController.text);
                  _discountAmount = (_totalAmount * discountPercentage) / 100;
                  _grandTotal = _totalAmount - _discountAmount + _taxAmount;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(4)),
                ),
                backgroundColor: Colors.brown,
                minimumSize: Size(80, 40),
              ),
              child: Text(
                'Apply',
                style: GoogleFonts.exo2(
                    color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isCashMode = true;
  bool _isUPIMode = false;
  bool _isCardMode = false;

  void _setMode(bool isCash, bool isUPI, bool isCard) {
    setState(() {
      _isCashMode = isCash;
      _isUPIMode = isUPI;
      _isCardMode = isCard;
    });
  }


  void _onNumberPressed(int number) {
    setState(() {
      _amount = (_amount * 10) + number;
    });
  }

  void _onPlusPressed() {
    setState(() {
      _amount = _amount + 1;
    });
  }

  void _onMinusPressed() {
    setState(() {
      _amount = _amount - 1;
    });
  }

  void _onPlus50Pressed() {
    setState(() {
      _amount = _amount + 50;
    });
  }

  void _onPlus100Pressed() {
    setState(() {
      _amount = _amount + 100;
    });
  }

  void _onPlus200Pressed() {
    setState(() {
      _amount = _amount + 200;
    });
  }

  void _onPlus500Pressed() {
    setState(() {
      _amount = _amount + 500;
    });
  }

  void _onValidatePressed() {
    setState(() {
      _paidAmount = _amount;
    });

    _showPaymentSuccessDialog();
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Payment Successful',
            style: GoogleFonts.exo(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          content: Text.rich(
            TextSpan(
              text: 'You have successfully paid ',
              style: GoogleFonts.exo2(fontSize: 16),
              children: [
                TextSpan(
                  text: ' ₹ $_paidAmount',
                  style: GoogleFonts.exo(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green), // Change color here
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text(
                'OK',
                style: GoogleFonts.exo2(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  void _eraseLastCharacter() {
    if (_amount != 0) {
      setState(() {
        // Convert the amount to a string, remove the last character, then convert back to int
        String amountStr = _amount.toString();
        amountStr = amountStr.substring(0, amountStr.length - 1);
        _amount = amountStr.isEmpty ? 0 : int.parse(amountStr);
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        //padding: EdgeInsets.all(16),
        color: Colors.grey.shade300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.arrow_circle_left_outlined, size: 28,color: primaryColor,),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 15),
                          Text(
                            'PAYMENT',
                            style: GoogleFonts.exo2(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: EdgeInsets.only(
                          right: 20, left: 20, top: 15, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white70,
                                child: Icon(Icons.person, color: primaryColor,
                                    size: 30),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'NAME',
                                style: GoogleFonts.exo2(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.local_offer),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 25, // Adjust the height as needed
                                  child: Text('LOYALTY CARD',
                                      style: GoogleFonts.exo2(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  height: 25, // Adjust the height as needed
                                  child: Text(
                                      'CARD TYPE', style: GoogleFonts.exo2()),
                                ),
                                Container(
                                  height: 25, // Adjust the height as needed
                                  child: Row(
                                    children: [
                                      Text(
                                          'BALANCE', style: GoogleFonts.exo2()),
                                      Spacer(),
                                      Text('$_balanceAmount',
                                          style: GoogleFonts.exo2()),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 25, // Adjust the height as needed
                                  child: Row(
                                    children: [
                                      Text('POINTS EARNED',
                                          style: GoogleFonts.exo2()),
                                      Spacer(),
                                      Text('$_pointsEarned',
                                          style: GoogleFonts.exo2()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text('Item', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      trailing: Text('1', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      dense: true,
                    ),
                    ListTile(
                      title: Text('Total', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      trailing: Text('$_totalAmount', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      dense: true,
                    ),
                    ListTile(
                      title: Text('Discount', style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                      trailing: Text('$_discountAmount',
                          style: GoogleFonts.exo2(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      dense: true,
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Taxable ', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      trailing: Text(' $_taxAmount', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      dense: true,
                    ),
                    ListTile(
                      title: Text('Tax ', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      trailing: Text('$_taxAmount', style: GoogleFonts.exo2(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                      dense: true,
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Grand Total ', style: GoogleFonts.exo2(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                      trailing: Text('$_grandTotal', style: GoogleFonts.exo2(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                      dense: true,
                    ),
                    Divider(),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        _buildElevatedButton('Discount  ₹', Colors.brown,
                                () => _applyDiscountInRupees(), radius: 5,
                            height: 55,
                            width: 225,
                            margin: EdgeInsets.zero),
                        _buildElevatedButton('Discount  %', Colors.brown,
                                () => _applyDiscountInPercentage(), radius: 5,
                            height: 55,
                            width: 225,
                            margin: EdgeInsets.zero),

                      ],
                    ),
                    ListTile(
                      title: Text('Due Amount  ', style: GoogleFonts.exo2(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                      trailing: Text('$_grandTotal', style: GoogleFonts.exo2(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(right: 12.0,top: 12,bottom: 12),
              padding: const EdgeInsets.all(10.0),
              //height: MediaQuery.of(context).size.height, // Set height to screen height
              child: Column(
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Column(
                          children: [
                            _buildElevatedButton('Cash', Colors.orange, () {
                              _setMode(true, false, false);
                            }, height: 60, width: 200),
                            _buildElevatedButton('UPI', Colors.orange, () {
                              _setMode(false, true, false);
                            }, height: 60, width: 200),
                            _buildElevatedButton('Card', Colors.orange, () {
                              _setMode(false, false, true);
                            }, height: 60, width: 200),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        //padding: EdgeInsets.only(right: 80),
                        width: 660,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (_isCashMode) _buildCashContainer(),
                            if (_isUPIMode) _buildUPIContainer(),
                            if (_isCardMode) _buildCardContainer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Quick Cash Payment',
                          style: GoogleFonts.exo2(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildbuttonContainer('₹ 15', Colors.brown,txtcolor: Colors.white,
                                height: 57, () {
                                  setState(() {
                                    _amount = 15;
                                  });
                                }),
                            _buildbuttonContainer('₹ 20', Colors.brown,txtcolor: Colors.white,
                                height: 57, () {
                                  setState(() {
                                    _amount = 20;
                                  });
                                }),
                            _buildbuttonContainer('₹ 50', Colors.brown,txtcolor: Colors.white,
                                height: 57, () {
                                  setState(() {
                                    _amount = 50;
                                  });
                                }),
                            _buildbuttonContainer('₹ 100', Colors.brown,txtcolor: Colors.white,
                                height: 57, () {
                                  setState(() {
                                    _amount = 100;
                                  });
                                }),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Text(
                        //   'Paid Amount: ₹ $_paidAmount',
                        //   style: GoogleFonts.exo2(fontWeight: FontWeight.w800,fontSize: 15),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildbuttonContainer(String text,
      Color? color,
      VoidCallback onTap, {
        double radius = 5,
        double? width,
        double? height,
        EdgeInsetsGeometry? margin,
        double? borderWidth,
        Color? txtcolor,
        double? size,
      }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin ?? EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
                width: borderWidth ?? 0.4, color: Colors.black38),
          ),
          height: height ?? 70,
          width: width ?? 135,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.exo(
                      fontWeight: FontWeight.bold,
                      fontSize: size ?? 15,
                      color: txtcolor ?? Colors.black,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildElevatedButton(String text,
      Color backgroundColor,
      VoidCallback onPressed,
      {
        double? radius = 5,
        double? width = 100,
        double? height = 50,
        EdgeInsetsGeometry? margin,
        Color? txtcolor,
      }) {
    return Container(
      margin: margin ?? EdgeInsets.all(5),
      //padding: EdgeInsets.all(5),
      width: width,
      height: height,
      decoration: BoxDecoration(
        //border: Border.all(width: 1, color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.exo2(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color:txtcolor ?? Colors.white
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
          shadowColor: Colors.transparent,

        ),
      ),
    );
  }

  Widget _buildCashContainer() {
    return Container(
      padding: EdgeInsets.only(right: 80),
      child: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.only(left: 65,),
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.8),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text('$_amount',
                    style: GoogleFonts.exo2(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Spacer(),
                IconButton(
                  onPressed: _eraseLastCharacter,
                  icon: Icon(Icons.backspace_outlined),
                ),
                SizedBox(width: 25),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _buildbuttonContainer('1', Colors.white, () => _onNumberPressed(1)),
              _buildbuttonContainer('2', Colors.white, () => _onNumberPressed(2)),
              _buildbuttonContainer('3', Colors.white, () => _onNumberPressed(3)),
              _buildbuttonContainer('+500', Colors.white,  _onPlus500Pressed),
            ],
          ),
          Row(
            children: [
              _buildbuttonContainer('4', Colors.white,  () => _onNumberPressed(4)),
              _buildbuttonContainer('5', Colors.white, () => _onNumberPressed(5)),
              _buildbuttonContainer('6', Colors.white,  () => _onNumberPressed(6)),
              _buildbuttonContainer('+200', Colors.white, _onPlus200Pressed),
            ],
          ),
          Row(
            children: [
              _buildbuttonContainer('7', Colors.white, () => _onNumberPressed(7)),
              _buildbuttonContainer('8', Colors.white, () => _onNumberPressed(8)),
              _buildbuttonContainer('9', Colors.white, () => _onNumberPressed(9)),
              _buildbuttonContainer('+100', Colors.white, _onPlus100Pressed),
            ],
          ),
          Row(
            children: [
              _buildbuttonContainer('+', Colors.white,  _onPlusPressed),
              _buildbuttonContainer('0', Colors.white,  () => _onNumberPressed(0)),
              _buildbuttonContainer('-', Colors.white,  _onMinusPressed),
              _buildbuttonContainer('+50', Colors.white, _onPlus50Pressed),
            ],
          ),
          _buildbuttonContainer('PAY  NOW ', Colors.green, txtcolor: Colors.white, size: 17,  _onValidatePressed, width: 600),
          SizedBox(height: 52),
        ],
      ),
    );
  }

  Widget _buildUPIContainer() {
    // Add your UPI container implementation here
    return Container(
      height: 542,
      //color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 360,
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey,)
            ),
            margin: EdgeInsets.all(10),
            child: Stack(
              children: [
                if (_pickedFile != null)
                  Center(
                    child: Image.file(
                      _pickedFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (_pickedFile == null)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No Image selected',
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          IconButton(
            onPressed: _pickFile,
            icon: Icon(Icons.add_photo_alternate_outlined),
            tooltip: "Select Image ",
          ),
        ],
      ),
    );
  }

  Widget _buildCardContainer() {
    return Container(
      height: 542,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Credit Card',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Expiry date',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Submit >'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'CVV Code',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'GB VISA',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '4123 4567 8910 1234',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Card Holder Name',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'JOHN DOE',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '*Disclaimer: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


