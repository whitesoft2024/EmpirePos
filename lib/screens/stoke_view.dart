import 'package:empirepos/screens/ItemList.dart';
import 'package:empirepos/screens/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../HomePage.dart';

class Item {
  final String? id;
  final String itemName;
  final String? itemCode;
  final String groupName;
  final String? purchaseRate;
  late final dynamic salesRate;
  String? price;
  final String? mrp;
  final String? cgst;
  final String? sgst;
  final String? brand;
  String? discount;
  String? quantity;


  Item({
     this.id,
    required this.itemName,
     this.itemCode,
    required this.groupName,
     this.purchaseRate,
    required this.salesRate,
    this.price,
     this.mrp,
     this.cgst,
     this.sgst,
     this.brand,
    this.discount = "0",
    this.quantity = "0",
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'] ?? '',
      itemName: json['itemName'] ?? '',
      itemCode: json['itemCode'] ?? '',
      groupName: json['groupName'] ?? '',
      purchaseRate: json['purchaseRate'] ?? '',
      salesRate: json['salesRate'] ?? '',
      mrp: json['mrp'] ?? '',
      cgst: json['cgst'] ?? '',
      sgst: json['sgst'] ?? '',
      brand: json['brand'] ?? '',
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paginated Products',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductCategoryPage(),
    );
  }
}

class ProductCategoryPage extends StatefulWidget {
  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  final Map<String, List<Item>> categories = {};
  bool isLoading = false;
  Item? selectedProduct;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true;
    });

    // Fetch API data and categorize it
    try {
      final response = await http.get(Uri.parse(
          'https://www.empairindia.com/api/getAllItems?page=1&limit=20&searchTerm='));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        Map<String, List<Item>> fetchedCategories = {};

        for (var item in data) {
          final product = Item.fromJson(item);
          fetchedCategories
              .putIfAbsent(product.groupName, () => [])
              .add(product);
        }

        setState(() {
          categories.addAll(fetchedCategories);
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Product Categories',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 25,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: categories.keys.length,
              itemBuilder: (context, index) {
                String category = categories.keys.elementAt(index);
                List<Item> products = categories[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 10),
                      child: Row(
                        children: [
                          Text(
                            category != null && category.isNotEmpty
                                ? '${category[0].toUpperCase()}${category.substring(1).toLowerCase()}'
                                : '',
                            style: GoogleFonts.exo2(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductListPage(
                                    category: category,
                                    initialItems: products,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'See All',
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 225,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length > 9 ? 9 : products.length,
                        itemBuilder: (context, productIndex) {
                          final product = products[productIndex];
                          bool isSelected = selectedProduct != null &&
                              selectedProduct!.id == product.id;
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                context.read<ProductProvider>().addProduct(product);
                                if (selectedProduct == null || selectedProduct!.id != product.id) {
                                  setState(() {
                                    selectedProduct = product;
                                  });
                                }
                              },
                              child: Card(
                                color: Color(0xFFFFFFFF),
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                                child: Container(
                                  width: 190,
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread content vertically
                                    children: [
                                      Flexible(
                                        flex: 4, // Adjust flex value as needed
                                        child: Icon(Icons.image_outlined,
                                            size: 100,
                                            color: Colors.blueGrey[800]),
                                      ),
                                      SizedBox(height: 8),
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          product.itemName != null && product.itemName.isNotEmpty
                                              ? '${product.itemName[0].toUpperCase()}${product.itemName.substring(1).toLowerCase()}'
                                              : 'No Name', // Default text when itemName is null or empty
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.exo2(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${product.salesRate}',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.exo2(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  context.read<ProductProvider>().toggleFavorite(product);
                                                },
                                                icon: Icon(
                                                  context.watch<ProductProvider>().isFavorite(product)
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      // if (isSelected)
                                      //   Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: Text(
                                      //       'Selected',
                                      //       style: GoogleFonts.exo2(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.green,
                                      //       ),
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class ProductListPage extends StatefulWidget {
  final String category;
  final List<Item> initialItems;

  ProductListPage({required this.category, required this.initialItems});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Item> items = [];
  int currentPage = 1;
  final int itemsPerPage = 10;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    items = widget.initialItems;
    fetchMoreItems();
  }

  Future<void> fetchMoreItems() async {
    if (!hasMore || isLoading) return;

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://www.empairindia.com/api/getAllItems?page=$currentPage&limit=$itemsPerPage&searchTerm=${Uri.encodeComponent(widget.category)}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List fetchedItems = jsonData['data'];

        setState(() {
          final existingIds = items.map((item) => item.id).toSet();

          final filteredItems = fetchedItems
              .map((item) => Item.fromJson(item))
              .where((item) =>
                  item.groupName == widget.category &&
                  !existingIds.contains(item.id))
              .toList();

          items.addAll(filteredItems);

          currentPage++;
          hasMore = fetchedItems.length == itemsPerPage;
        });
      } else {
        throw Exception('Failed to fetch items');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.category} Products',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 270, // Maximum width for each grid item
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return Center(child: CircularProgressIndicator());
          }
          final item = items[index];

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                context.read<ProductProvider>().addProduct(item);
              },
              child: Stack(
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                    child: Container(
                      width: 220,
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 6,
                              child: Icon(Icons.image_outlined, size: 100)),
                          SizedBox(height: 8),
                          Flexible(
                            flex: 2,
                            child: Text(
                              item.itemName,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.exo2(
                                  fontSize: 16,
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 8),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item.salesRate}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.exo2(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueGrey[800]),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.read<ProductProvider>().toggleFavorite(item);
                                    },
                                    icon: Icon(
                                      context.watch<ProductProvider>().isFavorite(item)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

          // return ListTile(
          //   title: Text(item.itemName),
          //   subtitle: Text('Brand: ${item.brand}'),
          //   trailing: Text('₹${item.salesRate}'),
          // );
        },
      ),
    );
  }
}
