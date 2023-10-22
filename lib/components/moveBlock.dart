import 'dart:async';

import 'package:first_flutter_prj/components/collision_block.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class MoveBlock extends CollisionBlock {
  final bool isStatic;
  final bool isVertical;
  final double offNeg;
  final double offPos;
  //double moveSpeed;

  MoveBlock({
    this.isStatic = true,
    this.isVertical = false,
    this.offNeg = 0,
    this.offPos = 0,
    //this.moveSpeed = 0,
    position,
    size,
  }) : super(
          position: position,
          size: size,
          isPlatform: true,
        );

  static const double stepTime = 0.1;
  static double moveSpeed = 50;
  static const tileSize = 16;
  double moveDirection = 1;
  double rangeNeg = 0;
  double rangePos = 0;
  bool isHorizontal = false;

  static Vector2 startingPosition = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    if (!isVertical) {
      isHorizontal = true;
    } else {
      isHorizontal = false;
    }
    priority = 0;
    startingPosition = Vector2(position.x, position.y);
    if (!isStatic) {
      if (isVertical) {
        rangeNeg = position.y - offNeg * tileSize;
        rangePos = position.y + offPos * tileSize;
      } else {
        rangeNeg = position.x - offNeg * tileSize;
        rangePos = position.x + offPos * tileSize;
      }
    } else {
      rangeNeg = 0;
      rangePos = 0;
    }
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Traps/Platforms/Brown Off.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: Vector2(32, 8),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (isVertical) {
      _moveVertically(dt);
    } else {
      _moveHorizontally(dt);
    }
    super.update(dt);
  }

  void _moveVertically(double dt) {
    if (position.y >= rangePos) {
      moveDirection = -1;
    } else if (position.y <= rangeNeg) {
      moveDirection = 1;
    }
    position.y += moveDirection * moveSpeed * dt;
  }

  void _moveHorizontally(double dt) {
    if (position.x >= rangePos) {
      moveDirection = -1;
    } else if (position.x <= rangeNeg) {
      moveDirection = 1;
    }
    position.x += moveDirection * moveSpeed * dt;
  }

  double getVelocity() {
    return moveSpeed;
  }
}
