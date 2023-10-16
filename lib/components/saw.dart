import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Saw extends SpriteAnimationComponent with HasGameRef<JumpKing> {
  final double offGoUp;
  Saw({
    this.offGoUp = 0,
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );
  static const stepTime = 0.1;
  static int moveSpeed = 10;
  @override
  FutureOr<void> onLoad() {
    priority = 0;
    add(CircleHitbox());
    debugMode = false;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Traps/Saw/On (38x38).png'),
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: stepTime,
        textureSize: Vector2.all(38),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += -moveSpeed * dt;
    super.update(dt);
  }
}
