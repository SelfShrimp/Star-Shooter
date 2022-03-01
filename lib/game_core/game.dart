import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:starshooter/scene/defeat_scene.dart';
import 'package:starshooter/scene/play_scene.dart';

import 'main_loop.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final ReceivePort _receivePort = ReceivePort(); //порт связи изолятов
  PlayScene _playScene = PlayScene();

  @override
  void initState() {
    () async {
      Isolate isolate = await Isolate.spawn(mainLoop, _receivePort.sendPort);
      _receivePort.listen((message) {
        _playScene.update();
        setState(() {});

        //не прерывается, поэтому в конце функции
        if (!running) {
          //убиваем изолят и слушатель
          isolate.kill(priority: Isolate.immediate);
          _receivePort.close();
          _playScene = PlayScene(); //очищаем поле
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Defeat()));
        }
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _playScene.buildScene();
  }
}
