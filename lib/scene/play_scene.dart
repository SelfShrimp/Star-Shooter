import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:starshooter/scene/app_scene.dart';
import 'package:starshooter/sprite/player_sprite.dart';

class PlayScene extends AppScene {
  final Player _player = Player();
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
      ],
    );
  }

  @override
  void update() {
    _player.update();
  }
}
