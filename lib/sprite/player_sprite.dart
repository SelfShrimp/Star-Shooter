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
  final double _size = 10.w;
  final List<Bullet> bullets = [];

  Ship(){
    x = 50.w; y = 80.h;
    x1 = x + _size; y1 = y + _size;
    () async {
      await Isolate.spawn(shotLoop, _receivePort.sendPort);
      _receivePort.listen((message) {
        //5w чтобы выстрелы летели перед кораблем, а не из его центра и сбоку
        bullets.add(Bullet(x, y-5.w));
        bullets.add(Bullet(x+8.w, y-5.w)); //10ширина корабля - 2ширина пули
      });
    }();
  }

  @override
  Widget build() {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        height: _size,
        width: _size,
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
    x1 = x + _size; y1 = y + _size;

    if (isNotPan) return;
    if (isMoveLeft) _speedX = -3;
    if (isMoveRight) _speedX = 3;

    x += _speedX;
    if (x < minWidth) {
      x = minWidth;
    } else if (x>maxWidth-_size){
      x = maxWidth-_size;
    }
  }
}