// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetModeAdapter extends TypeAdapter<BudgetMode> {
  @override
  final int typeId = 50;

  @override
  BudgetMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BudgetMode.economy;
      case 1:
        return BudgetMode.balanced;
      case 2:
        return BudgetMode.premium;
      case 3:
        return BudgetMode.custom;
      default:
        return BudgetMode.economy;
    }
  }

  @override
  void write(BinaryWriter writer, BudgetMode obj) {
    switch (obj) {
      case BudgetMode.economy:
        writer.writeByte(0);
        break;
      case BudgetMode.balanced:
        writer.writeByte(1);
        break;
      case BudgetMode.premium:
        writer.writeByte(2);
        break;
      case BudgetMode.custom:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
