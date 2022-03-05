import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

abstract class Sprite{
  double minWidth = 0.w, minHeight = 0.h, maxWidth = 100.w, maxHeight = 100.h;
  double x = 0;
  double y = 0;
  late double x1, y1; //нижний правый угол, высчитывается индивидуально

  void update() {
    move();
  }

  void move();

  Widget build();
}