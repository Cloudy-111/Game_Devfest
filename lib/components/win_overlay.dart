import 'package:first_flutter_prj/JumpKing.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class WinOverlay extends StatelessWidget {
  const WinOverlay(this.game, {super.key});

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
              Text(
                'Win!!',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(),
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
                  // final game = JumpKing();
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => GameWidget(
                  //       game: game,
                  //       overlayBuilderMap: <String,
                  //           Widget Function(BuildContext, Game)>{
                  //         'gameOverOverlay': (context, game) =>
                  //             GameOverOverlay(game),
                  //         'winOverlay': (context, game) => WinOverlay(game),
                  //       },
                  //     )
                  (game as JumpKing).resetGame();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 75),
                  ),
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text('Play Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
