import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/saw.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Game Over',
                // style: Theme.of(context).textTheme.displayMedium!.copyWith(),
                style: TextStyle(
                  fontFamily: 'Karma',
                  fontSize: 30,
                ),
              ),
              // const WhiteSpace(height: 50),
              // ScoreDisplay(
              //   game: game,
              //   isLight: true,
              // ),
              // const WhiteSpace(
              //   height: 50,
              // ),
              ElevatedButton(
                onPressed: () {
                  (game as JumpKing).resetGame();
                  Saw.moveSpeed = 17;
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 75),
                  ),
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    fontFamily: 'Karma',
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
