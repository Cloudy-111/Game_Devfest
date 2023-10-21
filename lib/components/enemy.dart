import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<JumpKing> {
  final String character;
  Enemy({
    // Sửa lại Assets sau: ThuyTinh
    this.character = "SonTinh",
    position,
    size,
  }) : super(position: position, size: size);

  Vector2 startPosition = Vector2.zero();
  final stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    priority = 1;
    debugMode = true;
    // Sửa lại animation sau
    animation = _spriteAnimation('Idle', 11);
    add(RectangleHitbox());
    return super.onLoad();
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      //tao ra animation cho doi tuong
      game.images.fromCache(
          'Main Characters/$character/$state (32x32).png'), //dung $ de the cho String
      SpriteAnimationData.sequenced(
          amount: amount, // co bao nhieu frame can hien
          stepTime: stepTime, // frame per second cho hoat anh
          textureSize: Vector2.all(32) // kich co 32 x 32
          ),
    );
  }
}
