
import 'dart:math';

import 'package:flutter/material.dart';

Color pickRandomColor() {
  final List<Color> possibleColors = [
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurpleAccent
  ];
  final index = Random().nextInt(possibleColors.length);
  return possibleColors[index];
}