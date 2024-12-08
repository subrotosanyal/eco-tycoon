import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resources.freezed.dart';

@freezed
class WaterResource with _$WaterResource {
  const WaterResource._();

  const factory WaterResource({
    @Default(0) int amount,
    @Default(100) int maxQuantity,
  }) = _WaterResource;

  String get name => 'water';
  String get label => 'Water';
  IconData get icon => Icons.water_drop;

  bool canSpend(int amount) => this.amount >= amount;

  WaterResource spend(int amount) {
    if (!canSpend(amount)) {
      throw Exception('Not enough water');
    }
    return copyWith(amount: this.amount - amount);
  }

  WaterResource regenerate(int amount) {
    return copyWith(
      amount: (this.amount + amount).clamp(0, maxQuantity),
    );
  }

  int operator +(int other) => amount + other;
  int operator -(int other) => amount - other;
}

@freezed
class EnergyResource with _$EnergyResource {
  const EnergyResource._();

  const factory EnergyResource({
    @Default(0) int amount,
    @Default(100) int maxQuantity,
  }) = _EnergyResource;

  String get name => 'energy';
  String get label => 'Energy';
  IconData get icon => Icons.bolt;

  bool canSpend(int amount) => this.amount >= amount;

  EnergyResource spend(int amount) {
    if (!canSpend(amount)) {
      throw Exception('Not enough energy');
    }
    return copyWith(amount: this.amount - amount);
  }

  EnergyResource regenerate(int amount) {
    return copyWith(
      amount: (this.amount + amount).clamp(0, maxQuantity),
    );
  }

  int operator +(int other) => amount + other;
  int operator -(int other) => amount - other;
}

@freezed
class SoilResource with _$SoilResource {
  const SoilResource._();

  const factory SoilResource({
    @Default(0) int amount,
    @Default(100) int maxQuantity,
  }) = _SoilResource;

  String get name => 'soil';
  String get label => 'Soil';
  IconData get icon => Icons.landscape;

  bool canSpend(int amount) => this.amount >= amount;

  SoilResource spend(int amount) {
    if (!canSpend(amount)) {
      throw Exception('Not enough soil');
    }
    return copyWith(amount: this.amount - amount);
  }

  SoilResource regenerate(int amount) {
    return copyWith(
      amount: (this.amount + amount).clamp(0, maxQuantity),
    );
  }

  int operator +(int other) => amount + other;
  int operator -(int other) => amount - other;
}
