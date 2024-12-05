import 'package:empirepos/screens/stoke_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Style/colors.dart';
import 'providers/product_provider.dart';

class BodyFlex4 extends StatefulWidget {


  @override
  _BodyFlex4State createState() => _BodyFlex4State();
}

class _BodyFlex4State extends State<BodyFlex4> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

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

  @override
  Widget build(BuildContext context) {
    var favoriteProducts = context.watch<ProductProvider>().favoriteProducts;

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Items :',
                  style: GoogleFonts.exo2(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteProducts.length,
                    itemBuilder: (context, index) {
                      _animationController.forward();
                      return SizeTransition(
                        sizeFactor: _animation,
                        child: buildItemCard(favoriteProducts[index], context),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildItemCard(Item product, BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<ProductProvider>().addProduct(product);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: SizeTransition(
            sizeFactor: _animation,
            child: Slidable(
              key: ValueKey(product),
              endActionPane: ActionPane(
                motion: StretchMotion(),
                extentRatio: 0.35,
                dismissible: DismissiblePane(
                  onDismissed: () {
                    if (context.read<ProductProvider>().isFavorite(product)) {
                      context.read<ProductProvider>().toggleFavorite(product);
                    }
                  },
                ),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_forever,
                    autoClose: true,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    label: 'Delete',
                    onPressed: (context) {
                      if (context.read<ProductProvider>().isFavorite(product)) {
                        context.read<ProductProvider>().toggleFavorite(product);
                      }
                    },
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: primaryColor.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Text(
                      product.itemName,
                      style: GoogleFonts.exo2(fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Text(
                      "Price: ${product.salesRate}",
                      style: GoogleFonts.exo2(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
