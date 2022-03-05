import 'package:flutter/material.dart';
import 'package:starshooter/game_core/main_loop.dart';
import 'package:starshooter/main.dart';

class Defeat extends StatelessWidget{
  const Defeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpg"), fit: BoxFit.none)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Game Over'),
          Container(
            height: 10,
          ),
          ElevatedButton(
              onPressed: (){
                running = true;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              child: const Text('Retry'))
        ],
      ),
    );
  }
}