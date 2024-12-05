import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool isSelected = false; // Example toggle state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('IconButton Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Basic IconButton
              IconButton(
                key: Key('basicIconButton'), // Key parameter
                icon: Icon(Icons.add), // Icon parameter
                iconSize: 36.0, // iconSize parameter
                visualDensity: VisualDensity(horizontal: -4, vertical: -4), // visualDensity parameter
                padding: EdgeInsets.all(12.0), // padding parameter
                alignment: Alignment.center, // alignment parameter
                splashRadius: 7.0, // splashRadius parameter
                color: Colors.blue, // color parameter
                focusColor: Colors.green, // focusColor parameter
                hoverColor: Colors.red, // hoverColor parameter
                highlightColor: Colors.yellow, // highlightColor parameter
                splashColor: Colors.purple, // splashColor parameter
                disabledColor: Colors.grey, // disabledColor parameter
                onPressed: () {
                  // onPressed parameter
                  print('Basic IconButton pressed');
                  // Add your custom action here
                },
                mouseCursor: MouseCursor.uncontrolled, // mouseCursor parameter
                focusNode: FocusNode(), // focusNode parameter
                autofocus: true, // autofocus parameter
                tooltip: 'Basic IconButton', // tooltip parameter
                enableFeedback: true, // enableFeedback parameter
                constraints: BoxConstraints.tightFor(width: 100.0, height: 100.0), // constraints parameter
                style: ButtonStyle(), // style parameter
                isSelected: isSelected, // isSelected parameter
                selectedIcon: Icon(Icons.check), // selectedIcon parameter
              ),
              SizedBox(height: 20),

              // IconButton with custom selected state
              IconButton(
                icon: isSelected ? Icon(Icons.star) : Icon(Icons.star_border),
                onPressed: () {
                  print('Toggle IconButton pressed');
                  // Toggle your custom state here
                },
                tooltip: isSelected ? 'Remove from favorites' : 'Add to favorites',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
