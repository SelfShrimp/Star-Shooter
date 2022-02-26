import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/sprite/app_sprite.dart';

class Meteor extends Sprite{
  bool isVisible = true;
  double _angle = 0; //вращение
  double _changeAngle = 0;
  late double _size;
  late int _speed;

  Meteor(){
    var random = Random();
    x = random.nextDouble() * 100.w;
    _size = 5.w + random.nextDouble() * 10.w;
    _speed = 1 + random.nextInt(3);
    _changeAngle = random.nextDouble() * 0.1;
  }

  @override
  Widget build() {
    return Positioned(
      left: x-5.w, //смещение к центру от половины ширины корабля
      top: y,
      child: Transform.rotate(
        angle: _angle,
        child: Container(
          height: _size,
          width: _size,
          padding: const EdgeInsets.all(5),
          child: const Image(image: AssetImage("assets/meteor.png"),),
        ),
      ),
    );
  }

  @override
  void move() {
    _angle += _changeAngle;
    y += _speed;
    if(y > maxHeight) isVisible = false;
  }

}