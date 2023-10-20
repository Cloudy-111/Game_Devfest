import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:flame/components.dart';

class CollisionBlock extends SpriteAnimationComponent
    with HasGameRef<JumpKing> {
  //class nay de nhan biet tuong va cac khoi khong di duoc, bi chan
  bool isPlatform;
  // bool isStatic;
  // bool isVertical;
  // double offNeg;
  // double offPos;
  CollisionBlock({
    position,
    size,
    this.isPlatform = false,
    //platform la block co the di xuyen qua tu duoi len
    // this.isStatic = true,
    // this.isVertical = false,
    // this.offNeg = 0,
    // this.offPos = 0,
  }) : super(
          position: position,
          size: size,
        ) {
    debugMode = false;
  }

  // static const stepTime = 0.1;
  // static int moveSpeed = 10;
  // static const tileSize = 16;
  // double moveDirection = 1;
  // double rangeNeg = 0;
  // double rangePos = 0;

  // static Vector2 startingPosition = Vector2.zero();

  // @override
  // FutureOr<void> onLoad() {
  //   startingPosition = Vector2(position.x, position.y);
  //   if (!isStatic) {
  //     if (isVertical) {
  //       rangeNeg = position.y - offNeg * tileSize;
  //       rangePos = position.y + offPos * tileSize;
  //     } else {
  //       rangeNeg = position.x - offNeg * tileSize;
  //       rangePos = position.x + offPos * tileSize;
  //     }
  //   } else {
  //     rangeNeg = 0;
  //     rangePos = 0;
  //   }

  //   animation = SpriteAnimation.fromFrameData(
  //     game.images.fromCache('Traps/Platforms/Brown Off.png'),
  //     SpriteAnimationData.sequenced(
  //       amount: 1,
  //       stepTime: stepTime,
  //       textureSize: Vector2(32, 8),
  //     ),
  //   );
  //   return super.onLoad();
  // }

  // @override
  // void update(double dt) {
  //   if (isVertical) {
  //     _moveVertically(dt);
  //   } else {
  //     _moveHorizontally(dt);
  //   }
  //   super.update(dt);
  // }

  // void _moveVertically(double dt) {
  //   if (position.y >= rangePos) {
  //     moveDirection = -1;
  //   } else if (position.y <= rangeNeg) {
  //     moveDirection = 1;
  //   }
  //   position.y += moveDirection * moveSpeed * dt;
  // }

  // void _moveHorizontally(double dt) {
  //   if (position.x >= rangePos) {
  //     moveDirection = -1;
  //   } else if (position.x <= rangeNeg) {
  //     moveDirection = 1;
  //   }
  //   position.x += moveDirection * moveSpeed * dt;
  // }
}
