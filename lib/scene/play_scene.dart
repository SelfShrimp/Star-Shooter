import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/game_core/main_loop.dart';
import 'package:starshooter/scene/app_scene.dart';
import 'package:starshooter/sprite/meteor_sprite.dart';
import 'package:starshooter/sprite/player_sprite.dart';

class PlayScene extends AppScene {
  final Ship _player = Ship();
  final List<Widget> _sprites = [];
  final List<Meteor> meteors = [];

  PlayScene(){
    final ReceivePort _receivePort = ReceivePort();
    () async {
      await Isolate.spawn(meteorLoop, _receivePort.sendPort);
      _receivePort.listen((message) {
        //5w чтобы выстрелы летели перед кораблем, а не из его центра
        meteors.add(Meteor());
      });
    }();
  }

  @override
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

  @override
  void update() {
    _player.update();
    _sprites.clear(); //очищаем спрайты
    _player.bullets.removeWhere((element) => !element.isVisible); //удаляем пули
    for (var element in _player.bullets) {
      element.update(); //двигаем
      _sprites.add(element.build()); //добавляем виджеты с их новой позицией
    }
    meteors.removeWhere((element) => !element.isVisible);
    for (var element in meteors) {
      element.update();
      _sprites.add(element.build());
    }
  }
}
