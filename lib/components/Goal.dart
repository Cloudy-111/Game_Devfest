import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/player_hitbox.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum PlayerState {
  idle,
  running,
}

class Goal extends SpriteAnimationGroupComponent with HasGameRef<JumpKing> {
  String character;
  Goal({
    position,
    this.character = 'Virtual Guy',
  }) : super(position: position);

  final double stepTime = 0.05;
  late final SpriteAnimation idleAnimation;
  Vector2 startingPosition = Vector2.zero();
  PlayerHitbox hitbox = PlayerHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );

  @override
  FutureOr<void> onLoad() {
    priority = 2;
    _loadAllAnimation();
    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  void _loadAllAnimation() {
    //idleAnimation
    idleAnimation = _spriteAnimation('Idle', 11);

    // tao cac animations
    animations = {
      PlayerState.idle: idleAnimation,
    }; //object animations hien tai la 1 phan tu trong enum co gia tri bang idleAnimation

    // dat animation hien tai
    current = PlayerState.idle;
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
