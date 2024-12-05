import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/close_icon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.fill
          ),
        ),
        //color: Colors.white,
        width: double.infinity, // Ensure the container takes full width
        height: double.infinity,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 80),
              width: screenWidth / 2, // Increase the width slightly
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     SizedBox(width: 30,),
                  //     Image(
                  //       image: AssetImage("asset/images/logo_2.png",),
                  //       //color: Colors.black,
                  //       height: 70,
                  //       width: 70,
                  //     )
                  //   ],
                  // ),
                  //SizedBox(height: 150,),
                  Container(
                    height: 500,
                    width: 650,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Positioned(
                          bottom: 5,
                          right: 35, // Move to the right without cutting off
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.shade200,
                              width: 250,
                              height: 250,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Container(
                            color: Colors.black38,
                            height: 540,
                            width: 500,
                            child: Image.asset(
                              'assets/images/logo17.png',
                              width:10,
                              height:10,
                              fit: BoxFit.contain,
                              scale: 0.2,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          right: 53,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "       Welcome To \n Ashraf's Restorent",
                                style: GoogleFonts.exo2(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Login to access your account',
                                style: GoogleFonts.albertSans(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50,top: 10,right: 10),
              width: screenWidth / 2 , // Adjust width accordingly
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      CloseIcon(),
                    ],
                  ),
                  SizedBox(height: 70),
                  Text(
                    "ENTER PIN",
                    style: GoogleFonts.rubik(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  PinInputWidget(), // Your PinInputWidget here
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.call_sharp,
                        size: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '+91 9747500080',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PinInputWidget extends StatefulWidget {
  @override
  _PinInputWidgetState createState() => _PinInputWidgetState();
}

class _PinInputWidgetState extends State<PinInputWidget> {
  final List<String> _pin = ['', '', '', ''];

  void _handleKeyPress(String value) {
    setState(() {
      for (int i = 0; i < _pin.length; i++) {
        if (_pin[i] == '') {
          _pin[i] = value;
          break;
        }
      }
    });
  }

  void _handleBackspace() {
    setState(() {
      for (int i = _pin.length - 1; i >= 0; i--) {
        if (_pin[i] != '') {
          _pin[i] = '';
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _pin.map((value) {
            return Container(
              margin: EdgeInsets.all(3),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400, width: 2.5),
                color: value == '' ? Colors.transparent : Colors.orange,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 40),
        Container(
          width: 300, // Set a fixed width for the GridView
          //height: 360, // Set a fixed height for the GridView
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 18,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              if (index == 9) {
                return SizedBox.shrink();
              } else if (index == 11) {
                return GestureDetector(
                  onTap: _handleBackspace,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent, // Transparent background
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1.3), // Grey border
                      ),
                      child: Center(
                        child: Icon(
                          Icons.backspace_outlined,
                          size: 20,
                          color: Colors.black, // Icon color
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                String value = (index == 10) ? '0' : (index + 1).toString();
                return GestureDetector(
                  onTap: () => _handleKeyPress(value),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent, // Transparent background
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1.3), // Grey border
                      ),
                      child: Center(
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 20, color: Colors.black), // Text color
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
