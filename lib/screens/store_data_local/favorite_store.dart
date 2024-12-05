import 'package:hive/hive.dart';

part 'favorite_store.g.dart';

@HiveType(typeId: 0) // Ensure typeId is unique
class Item1 extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String itemName;

  @HiveField(2)
  final double salesRate;

  Item1({
    required this.id,
    required this.itemName,
    required this.salesRate,
  });
}
