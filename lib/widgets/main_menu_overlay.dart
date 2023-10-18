import 'package:first_flutter_prj/JumpKing.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  @override
  Widget build(BuildContext context) {
    JumpKing game = widget.game as JumpKing;

    return Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý khi người chơi chọn "New Game"
                      final game = JumpKing();
                      game.startGame();
                      //Navigator.pop(context); // Đóng overlay
                    },
                    child: Text('New Game'),
                  ),
                ],
              )),
            )));
  }
}
