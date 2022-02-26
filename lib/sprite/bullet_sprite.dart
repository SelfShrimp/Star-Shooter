import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/sprite/app_sprite.dart';

class Bullet extends Sprite{
  bool isVisible = true;
  final double _height = 5.w;
  final double _width = 2.w;

  Bullet(double x, double y){
    this.x = x;
    this.y = y;
    x1 = x + _width; y1 = y + _height;
  }

  @override
  Widget build() {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        height: _height,
        width: _width,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 3, color: Colors.deepOrange),
          color: Colors.orange
        ),
      ),
    );
  }

  @override
  void move() {
    y-=5;
    if(y < minHeight-5.w) isVisible = false;

    x1 = x + _width; y1 = y + _height;
  }

}