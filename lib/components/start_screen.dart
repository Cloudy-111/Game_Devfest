import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/game_over_overlay.dart';
import 'package:first_flutter_prj/components/win_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
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
                image: Image.asset(
                  'assets/images/Background/start_background.png',
                  width: 200, // Chiều rộng của hình ảnh
                  height: 150, // Chiều cao của hình ảnh
                ).image,
                fit: BoxFit.cover,
              ),
              // color: Color(0xFF211F30),
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to JumpKing',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Karma',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final game = JumpKing();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => GameWidget(
                        game: game,
                        overlayBuilderMap: <String,
                            Widget Function(BuildContext, Game)>{
                          'gameOverOverlay': (context, game) =>
                              GameOverOverlay(game),
                          'winOverlay': (context, game) => WinOverlay(game),
                        },
                      ),
                    ));
                  },
                  child: const Text(
                    'Start Game',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Karma',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
