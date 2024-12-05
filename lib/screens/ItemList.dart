import 'package:empirepos/screens/providers/product_provider.dart';
import 'package:empirepos/screens/shared_class.dart';
import 'package:empirepos/screens/stoke_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Style/colors.dart';
import 'Payment_Page.dart';

class BodyFlex3 extends StatefulWidget {
  @override
  _BodyFlex3State createState() => _BodyFlex3State();
}

class _BodyFlex3State extends State<BodyFlex3> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;


  bool _isQtyMode = false;
  bool _isDiscMode = false;
  bool _isPriceMode = false;

  String _price = "";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentScreen();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final selectedProducts = context.watch<ProductProvider>().selectedProducts;
    final product = context.watch<ProductProvider>().selectedProduct;

    if (!_isPriceMode && product != null) {
      _price = product.price ?? product.salesRate; // Default to `salesRate` if `price` is null.
    }

    double pricetotal = selectedProducts.fold(0.0, (sum, item) {
      double price = 0.0;
      try {
        price = double.parse(item.salesRate);
      } catch (e) {
        print("Error parsing sales rate for item: ${item.itemName} with salesRate: ${item.salesRate}");
      }
      return sum + price;
    });

    double Cgsttotal = selectedProducts.fold(0.0, (sum, item) {
      double Cgst = 0.0;
      try {
        Cgst = double.parse(item.cgst!);
      } catch (e) {
        print("Error parsing sales rate for item: ${item.itemName} with CGST: ${item.cgst}");
      }
      return sum + Cgst;
    });

    double Sgsttotal = selectedProducts.fold(0.0, (sum, item) {
      double Sgst = 0.0;
      try {
        Sgst = double.parse(item.sgst!);
      } catch (e) {
        print("Error parsing sales rate for item: ${item.itemName} with SGST: ${item.sgst}");
      }
      return sum + Sgst;
    });

    double DiscTotal = selectedProducts.fold(0.0, (sum, item) {
      double Sgst = 0.0;
      try {
        Sgst =  item.discount as double ;
      } catch (e) {
        print("Error parsing sales rate for item: ${item.itemName} with Discount: ${item.discount}");
      }
      return sum + Sgst;
    });

    return Column(
      children: [
        SizedBox(height: 10),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            constraints: BoxConstraints(minHeight: 300),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
              color: Colors.white,
              image: DecorationImage(
                scale: 1.0,
                opacity: 0.5,
                image: AssetImage("assets/images/logo12.png"),
                fit: BoxFit.contain,
              ),
            ),
            child: SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                itemCount: selectedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  _animationController.forward();
                  return SizeTransition(
                    sizeFactor: _animation,
                    child: _buildItemList(selectedProducts[index]),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Container(
          height: 80,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildRow("LINES", "${selectedProducts.length}", "SUBTOTAL", "${pricetotal.toStringAsFixed(2)}"),
                _buildRow("DISCOUNT", '${DiscTotal.toStringAsFixed(2)}','CGST', "${Cgsttotal.toStringAsFixed(2)}"),
                _buildRow("ROUND OFF", "0", "SGST", "${Sgsttotal.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ),
        Container(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _showPaymentDialog,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder()),
            ),
            child: Text(
              'Payment',
              style: GoogleFonts.exo2(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String title, String value, String title1, String value1) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 20,
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.exo2(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  value,
                  style: GoogleFonts.exo2(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: Container(
            height: 20,
            child: Row(
              children: [
                Text(
                  title1,
                  style: GoogleFonts.exo2(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  value1,
                  style: GoogleFonts.exo2(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemList(Item item) {
    return GestureDetector(
      onTap: (){
        context.read<ProductProvider>().selectProduct(item);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Slidable(
          key: ValueKey(item),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.25,
            dismissible: DismissiblePane(
              onDismissed: () => context.read<ProductProvider>().removeProductFromSelected(item),
            ),
            children: [
              SlidableAction(
                backgroundColor: Colors.red.shade400,
                icon: Icons.delete_forever,
                foregroundColor: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                label: 'Delete',
                onPressed: (context) {
                  context.read<ProductProvider>().removeProductFromSelected(item);
                },
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black.withOpacity(0.7), width: 2),
            ),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black87, width: 2),
                    ),
                    child: Center(
                      child: Text(item.quantity ?? "0"), // Display current quantity
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    item.itemName,
                    style: GoogleFonts.exo2(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 45,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price : ${_isPriceMode ? item.price : item.salesRate}", // Conditionally display price
                          style: GoogleFonts.exo2(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Disc  : ${item.discount ?? "0"}", // Display current discount
                          style: GoogleFonts.exo2(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }

}
