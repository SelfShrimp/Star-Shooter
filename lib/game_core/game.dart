import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:starshooter/scene/play_scene.dart';

import 'main_loop.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game>{
  final ReceivePort _receivePort = ReceivePort();
  final PlayScene _playScene = PlayScene();

  @override
  void initState() {
    () async {
      await Isolate.spawn(mainLoop, _receivePort.sendPort);
      _receivePort.listen((message) {
        _playScene.update();
        setState(() {});
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _playScene.buildScene();
  }
}