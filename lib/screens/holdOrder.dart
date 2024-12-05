import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Style/colors.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Desktop App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: holdorder(),
    );
  }
}

class holdorder extends StatefulWidget {
  @override
  _HoldOrderState createState() => _HoldOrderState();
}

class _HoldOrderState extends State<holdorder> {
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic>? selectedOrder;

  // Sample list of all orders
  List<Map<String, dynamic>> allOrders = [
    {
      'id': '654321',
      'time': '1:02 PM',
      'username': 'user3',
      'items': [
        {'name': 'Widget A', 'price': 20.00},
        {'name': 'Widget B', 'price': 55.00}
      ],
      'totalPrice': 75.00,
    },
    {
      'id': '654322',
      'time': '1:40 PM',
      'username': 'user4',
      'items': [
        {'name': 'Widget A', 'price': 25.00},
        {'name': 'Widget B', 'price': 30.00},
        // Add more items as needed
      ],
      'totalPrice': 85.00,
    },
    {
      'id': '654323',
      'time': '1:20 PM',
      'username': 'user5',
      'items': [
        {'name': 'Widget A', 'price': 10.00},
        {'name': 'Widget B', 'price': 25.00}
      ],
      'totalPrice': 35.00,
    },
    // Add more all orders as needed
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate() {
    return DateFormat('dd - MM - yyyy').format(selectedDate);
  }

  void _selectOrder(Map<String, dynamic> order) {
    setState(() {
      selectedOrder = order;
      print(selectedOrder!['items']);
    });
  }

  void _addOrder() {
    // Add order functionality
    print("Add button pressed");
  }

  void _printOrder() {
    // Print order functionality
    print("Print button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: primaryColor,
        title: Text(
          'HOLD ORDERS',
          style: GoogleFonts.exo2(
              color: primaryColor, fontWeight: FontWeight.w700, fontSize: 17),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            // Main Container
            Container(
              color: Colors.grey.shade200,
              width: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      itemCount: allOrders.length,
                      itemBuilder: (context, index) {
                        var order = allOrders[index];
                        return GestureDetector(
                          onTap: () => _selectOrder(order),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order #${order['id']}',
                                      style: GoogleFonts.exo2(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Time: ${order['time']}',
                                      style: GoogleFonts.exo2(fontSize: 14),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'User: ${order['username']}',
                                      style: GoogleFonts.exo2(fontSize: 14),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Total: \$${order['totalPrice'].toStringAsFixed(2)}',
                                      style: GoogleFonts.exo2(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios, size: 16,color: primaryColor,),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(width: 10,),
            //Divider(color: Colors.brown, thickness: 4.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.1),
                      //     blurRadius: 2,
                      //     spreadRadius: 1,
                      //     offset: Offset(0, 0),
                      //   ),
                      // ],
                      color: Colors.grey.shade200,
                    ),
                    height: MediaQuery.of(context).size.height - 146,
                    margin: EdgeInsets.only(right: 10,left: 10,bottom: 10),
                    padding: EdgeInsets.only(right: 50, left: 50, top: 30),
                    child: selectedOrder != null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #${selectedOrder!['id']}',
                          style: GoogleFonts.exo2(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Time: ${selectedOrder!['time']}',
                          style: GoogleFonts.exo2(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'User: ${selectedOrder!['username']}',
                          style: GoogleFonts.exo2(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total: \$ ${selectedOrder!['totalPrice'].toStringAsFixed(2)}',
                          style: GoogleFonts.exo2(fontSize: 18),
                        ),
                        Divider(color: Colors.black54, thickness: 2.0),
                        SizedBox(height: 10),
                        Text(
                          'Items:',
                          style: GoogleFonts.exo2(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: selectedOrder!['items'].length,
                            itemBuilder: (context, index) {
                              var item = selectedOrder!['items'][index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: GoogleFonts.exo2(fontSize: 16),
                                    ),
                                    Text(
                                      '\$${item['price'].toStringAsFixed(2)}',
                                      style: GoogleFonts.exo2(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                        : Center(
                      child: Text(
                        'Select an order to view details',
                        style: GoogleFonts.exo2(fontSize: 16),
                      ),
                    ),
                  ),
                  //SizedBox(height: 10,),
                  Container(
                    height: 70,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            //color: primaryOpacity,
                            //border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: ElevatedButton(
                            onPressed: _addOrder,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                              ),
                              backgroundColor: primaryOpacity,
                              minimumSize: Size(350, 60),
                            ),
                            child: Text(
                              'ADD',
                              style: GoogleFonts.exo2(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: _printOrder,
                        //   style: ElevatedButton.styleFrom(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(Radius.circular(4)),
                        //     ),
                        //     backgroundColor: primaryOpacity,
                        //     minimumSize: Size(700, 60),
                        //   ),
                        //   child: Text(
                        //     'PRINT',
                        //     style: GoogleFonts.exo2(
                        //         color: Colors.white, fontSize: 16),
                        //   ),
                        // ),
                      ],
                    ),
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
