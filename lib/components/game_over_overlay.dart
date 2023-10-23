import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/saw.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 1, // Tỷ lệ chiều rộng của khung
          heightFactor: 1, // Tỷ lệ chiều cao của khung
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset('assets/images/Background/start_background.png').image,
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'K1',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: (){
                    (game as JumpKing).resetGame();
                    Saw.moveSpeed = 17;
                  },
                  child: Text(
                      'Play Again',
                      style: TextStyle(
                        fontFamily: 'K1',
                        fontSize: 18,
                        color: Colors.white,
                      )
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
