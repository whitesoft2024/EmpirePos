import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/providers/product_provider.dart';

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  bool _isQtyMode = false;
  bool _isDiscMode = false;
  bool _isPriceMode = false;

  String _quantity = '';
  String _discount = '';
  String _price = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNumberButton("7"),
            _buildNumberButton("8"),
            _buildNumberButton("9"),
            _buildQtyButton("QTY"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButton("4"),
            _buildNumberButton("5"),
            _buildNumberButton("6"),
            _buildDiscButton("DISC"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButton("1"),
            _buildNumberButton("2"),
            _buildNumberButton("3"),
            _buildPriceButton("PRICE"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButton("."),
            _buildNumberButton("0"),
            _buildClearButton("C"),
            _buildBackButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String buttonText) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(0.5),
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            _updateValue(buttonText);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder()),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildQtyButton(String buttonQtyText) {
    return _buildModeButton(
      buttonQtyText,
          () => _setMode(isQtyMode: true),
    );
  }

  Widget _buildDiscButton(String buttonDiscText) {
    return _buildModeButton(
      buttonDiscText,
          () => _setMode(isDiscMode: true),
    );
  }

  Widget _buildPriceButton(String buttonPriceText) {
    return _buildModeButton(
      buttonPriceText,
          () => _setMode(isPriceMode: true),
    );
  }

  Widget _buildClearButton(String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(0.5),
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            _resetAllInputs();
            context.read<ProductProvider>().updateQuantity("0");
            context.read<ProductProvider>().updateDiscount("0");
            context.read<ProductProvider>().updatePrice("0");
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder()),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(0.5),
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (_isQtyMode && _quantity.isNotEmpty) {
                _quantity = _quantity.substring(0, _quantity.length - 1);
                context.read<ProductProvider>().updateQuantity(_quantity.isEmpty ? "0" : _quantity);
              } else if (_isDiscMode && _discount.isNotEmpty) {
                _discount = _discount.substring(0, _discount.length - 1);
                context.read<ProductProvider>().updateDiscount(_discount.isEmpty ? "0" : _discount);
              } else if (_isPriceMode && _price.isNotEmpty) {
                _price = _price.substring(0, _price.length - 1);
                context.read<ProductProvider>().updatePrice(_price.isEmpty ? "0" : _price);
              }
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder()),
          ),
          child: Icon(Icons.backspace, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildModeButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(0.5),
        height: 80,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder()),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }

  void _updateValue(String input) {
    setState(() {
      if (_isQtyMode) {
        if (_quantity.length < 4) _quantity += input;
        context.read<ProductProvider>().updateQuantity(_quantity);
      } else if (_isDiscMode) {
        if (_discount.length < 4) _discount += input;
        context.read<ProductProvider>().updateDiscount(_discount);
      } else if (_isPriceMode) {
        // If in price mode, update the product price
        _price += input;
        context.read<ProductProvider>().updatePrice(_price);
      }
    });
  }

  void _resetAllInputs() {
    setState(() {
      _quantity = '';
      _discount = '';
      _price = '';
    });
  }

  void _setMode({bool isQtyMode = false, bool isDiscMode = false, bool isPriceMode = false}) {
    setState(() {
      _isQtyMode = isQtyMode;
      _isDiscMode = isDiscMode;
      _isPriceMode = isPriceMode;
    });
  }

  void _clearPrice() {
    setState(() {
      _price = '';
    });
  }

}
