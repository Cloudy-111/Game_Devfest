import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<JumpKing>, TapCallbacks {
  JumpButton();

  final margin = 32;
  final buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    position = Vector2(
      game.size.x - margin - buttonSize,
      game.size.y - margin - buttonSize,
    );
    priority = 2;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.pressTime ??= DateTime.now();
    game.player.hasJumped = false;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = true;
    DateTime end = DateTime.now();
    game.player.dur = end.difference(game.player.pressTime!).inMilliseconds;
    game.player.pressTime = null;
    super.onTapUp(event);
  }
}
