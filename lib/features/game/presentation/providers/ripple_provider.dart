import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RippleState {
  final Offset position;

  const RippleState({required this.position});
}

class RippleNotifier extends StateNotifier<RippleState?> {
  RippleNotifier() : super(null);

  void showRipple(Offset position) {
    state = RippleState(position: position);
  }

  void hideRipple() {
    state = null;
  }
}

final rippleStateProvider = StateNotifierProvider<RippleNotifier, RippleState?>((ref) {
  return RippleNotifier();
});
