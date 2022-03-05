import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/game_core/main_loop.dart';
import 'package:starshooter/sprite/app_sprite.dart';
import 'package:starshooter/sprite/meteor_sprite.dart';
import 'package:starshooter/sprite/player_sprite.dart';

class PlayScene{
  final Ship _player = Ship();
  final List<Widget> _sprites = [];
  final List<Meteor> _meteors = [];

  PlayScene(){
    final ReceivePort _receivePort = ReceivePort();
    () async {
      Isolate isolate = await Isolate.spawn(meteorLoop, _receivePort.sendPort);
      _receivePort.listen((message) {
        _meteors.add(Meteor());

        if (!running) {
          isolate.kill(priority: Isolate.immediate);
          _receivePort.close();
          _sprites.clear();
          _meteors.clear();
        }
      });
    }();
  }

  Widget buildScene() {
    return Stack(
      children: [
        _player.build(),
        Positioned(
          left: 5.w,
          top: 88.h,
          child: GestureDetector(
            onPanStart: (details){
              _player.isNotPan = false;
              _player.isMoveLeft = true;
            },
            onPanEnd: (details){
              _player.isNotPan = true;
              _player.isMoveLeft = false;
            },
            child: Container(
                height: 10.h,
                width: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Colors.blueGrey),
                ),
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.blueGrey,
                  size: 25,
                )),
          ),
        ),
        Positioned(
          right: 5.w,
          top: 88.h,
          child: GestureDetector(
            onPanStart: (details){
              _player.isNotPan = false;
              _player.isMoveRight = true;
            },
            onPanEnd: (details){
              _player.isNotPan = true;
              _player.isMoveRight = false;
            },
            child: Container(
                height: 10.h,
                width: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Colors.blueGrey),
                ),
                child: const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.blueGrey,
                  size: 25,
                )),
          ),
        ),
        Stack(
          children: _sprites,
        )
      ],
    );
  }

  void update() {
    //пересечение метеора и игрока
    for (var element in _meteors) {
      //sqrt((x1-x0)^2 + (y1-y0)^2) //xy по формуле центры кругов
      double d = sqrt(
          pow((element.x+element.size/2)-(_player.x+_player.size/2),2) +
              pow((element.y+element.size/2)-(_player.y+_player.size/2),2)
      );
      //d > r0 + r1 non intersect
      //-10методом подбора, чтобы метеорит именно касался щита корабля
      //TODO: узнать как на других размерах экрана
      if (d <= element.size/2 + (_player.size-10)/2){
        stopLoop();
        return;
      }
    }
    _player.update();
    _sprites.clear(); //очищаем спрайты

    //проверка на пересечении выстрела и метеора
    for (var bullet in _player.bullets) {
      for (var meteor in _meteors) {
        if ((bullet.x <= meteor.x1 && bullet.x1 >= meteor.x) &&
            (bullet.y <= meteor.y1 && bullet.y1 >= meteor.y)) {
          bullet.isVisible = false;
          meteor.isVisible = false;
        }
      }
    }

    _player.bullets.removeWhere((element) => !element.isVisible); //удаляем пули
    _meteors.removeWhere((element) => !element.isVisible);

    for (var bullet in _player.bullets) {
      bullet.update(); //двигаем
      _sprites.add(bullet.build()); //добавляем виджеты с их новой позицией
    }
    for (var element in _meteors) {
      element.update();
      _sprites.add(element.build());
    }
  }
}
