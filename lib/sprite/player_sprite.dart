import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/game_core/main_loop.dart';
import 'package:starshooter/sprite/app_sprite.dart';

import 'bullet_sprite.dart';

class Ship extends Sprite {
  final ReceivePort _receivePort = ReceivePort();
  bool isMoveLeft = false;
  bool isMoveRight = false;
  bool isNotPan = true;
  double _speedX = 0;
  final List<Bullet> bullets = [];

  Ship(){
    x = 50.w;
    y = 80.h;
    () async {
      await Isolate.spawn(shotLoop, _receivePort.sendPort);
      _receivePort.listen((message) {
        //5w чтобы выстрелы летели перед кораблем, а не из его центра
        bullets.add(Bullet(x, y-5.w));
      });
    }();
  }

  @override
  Widget build() {
    return Positioned(
      left: x-5.w, //смещение к центру от половины ширины корабля
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
    //5w дурацкие смещения для выравнивания
    if (x < minWidth+5.w) {
      x = minWidth+5.w;
    } else if (x>maxWidth-5.w){
      x = maxWidth-5.w;
    }
  }
}