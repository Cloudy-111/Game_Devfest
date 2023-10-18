import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Saw extends SpriteAnimationComponent
    with HasGameRef<JumpKing>, CollisionCallbacks {
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
  static int moveSpeed = 17;

  static Vector2 startingPosition = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    priority = 0;
    add(RectangleHitbox());
    debugMode = false;
    startingPosition = Vector2(position.x, position.y);
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Other/water_level.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: Vector2(336, 32),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += -moveSpeed * dt;
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) _stop();
    super.onCollisionStart(intersectionPoints, other);
  }

  void _stop() {
    position = startingPosition;
  }
}
