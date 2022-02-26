import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/sprite/app_sprite.dart';

class Player extends Sprite {
  Player(){
    x = 50.w;
    y = 80.h;
  }

  bool isMoveLeft = false;
  bool isMoveRight = false;
  bool isNotPan = true;
  double _speedX = 0;

  @override
  Widget build() {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        height: 10.w,
        width: 10.w,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1, color: Colors.lightBlueAccent),
        ),
        child: const Image(image: AssetImage("assets/spaceship.png"),),
      ),
    );
  }

  @override
  void move() {
    if (isNotPan) return;
    if (isMoveLeft) _speedX = -3;
    if (isMoveRight) _speedX = 3;

    x += _speedX;
    if (x < minWidth) {
      x = minWidth;
    } else if (x>maxWidth-10.w){
      x = maxWidth-10.w;
    }
  }

}