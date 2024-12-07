import 'package:flutter/material.dart';

abstract class GameCommand {
  String get name;
  String get label;
  IconData get icon;
  Color get color;
  bool get isEnabled;
  Future<void> execute();
}
