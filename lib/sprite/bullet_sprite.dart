import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/sprite/app_sprite.dart';

class Bullet extends Sprite{
  bool isVisible = true;

  Bullet(double x, double y){
    this.x = x;
    this.y = y;
  }

  @override
  Widget build() {
    return Positioned(
      left: x-5, //выравнивание к центру от половины ширины спрайта
      top: y,
      child: Container(
        height: 5.w,
        width: 10,
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
    if(y < 0.h-5.w) isVisible = false;
  }

}