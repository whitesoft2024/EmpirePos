import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:empirepos/screens/stoke_view.dart';
import 'package:empirepos/screens/store_data_local/favorite_store.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'screens/providers/product_provider.dart';
import '../screens/shared_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(Item1Adapter());

  await Hive.openBox<Item>('favoriteProducts');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => QuantityNotifier()),
      ],
      child: MyApp(),
    ),

  );
  doWhenWindowReady(() {
    final maxSize = Size(double.minPositive, double.minPositive);
    appWindow.minSize = const Size(300, 504);
    appWindow.maxSize = maxSize;
    appWindow.alignment = Alignment.topLeft;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
