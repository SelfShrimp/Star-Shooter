import 'package:flutter/material.dart';
import 'package:starshooter/scene/play_scene.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game>{
  @override
  Widget build(BuildContext context) {
    return PlayScene().buildScene();
  }
}