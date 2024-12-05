// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Item1Adapter extends TypeAdapter<Item1> {
  @override
  final int typeId = 0;

  @override
  Item1 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item1(
      id: fields[0] as int,
      itemName: fields[1] as String,
      salesRate: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Item1 obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.salesRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item1Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
