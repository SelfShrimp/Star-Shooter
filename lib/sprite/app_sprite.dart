import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

abstract class Sprite{
  double minWidth = 0.w, minHeight = 0.h, maxWidth = 100.w, maxHeight = 100.h;
  double x = 0;
  double y = 0;

  void update() {
    move();
  }

  void move();

  Widget build();
}