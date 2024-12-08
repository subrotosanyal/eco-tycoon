import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_resource.freezed.dart';

@freezed
class BaseResource with _$BaseResource {
  const BaseResource._(); // Private constructor for methods

  const factory BaseResource({
    required String name,
    required String label,
    required IconData icon,
    @Default(0) int amount,
    @Default(100) int maxQuantity,
  }) = _BaseResource;

  bool canSpend(int amount) {
    return this.amount >= amount;
  }

  BaseResource spend(int amount) {
    if (!canSpend(amount)) {
      throw Exception('Not enough $label');
    }
    return copyWith(amount: this.amount - amount);
  }

  BaseResource regenerate(int amount) {
    return copyWith(
      amount: (this.amount + amount).clamp(0, maxQuantity),
    );
  }

  int operator +(int other) => amount + other;
  int operator -(int other) => amount - other;
}
