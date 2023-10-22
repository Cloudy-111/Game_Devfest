import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Saw extends SpriteAnimationComponent
    with HasGameRef<JumpKing>, CollisionCallbacks {
  double offGoUp;
  Saw({
    this.offGoUp = 0,
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );
  static const stepTime = 0.1;
  static double moveSpeed = 17;
  bool isGameInit = false;
  bool isWin = false;

  static Vector2 startingPosition = Vector2.zero();
  Vector2 startPosition = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    priority = 1;
    add(RectangleHitbox());
    debugMode = false;
    startingPosition = Vector2(position.x, position.y);
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Other/water_large.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: Vector2(368, 640),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    //position.y += -moveSpeed * dt;
    _updateTsunami(dt);
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      (game as JumpKing).onLose();
      _respawn();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _respawn() {
    if (!game.playSound) {
      FlameAudio.play('hitHurt.wav', volume: game.soundVolume);
    }
    isGameInit = false;
    position = startingPosition;
    moveSpeed = 0;
    gameRef.thuyTinh.position = gameRef.thuyTinh.startPosition;
  }

  void _updateTsunami(double dt) {
    //skip first init frame
    if (!isGameInit) {
      isGameInit = true;
      return;
    }

    // cho sóng luôn ở đáy nếu màn hình vượt trên sóng khởi tạo
    final double bottomScreenPosition =
        gameRef.cam.viewfinder.position.y + gameRef.gameResolution.y / 2;
    if (bottomScreenPosition >= position.y) {
      // cập nhật sóng như bình thường nếu vẫn trong khung hình
      position.y += -moveSpeed * dt;
      gameRef.thuyTinh.y += -moveSpeed * dt;
    } else {
      position.y = bottomScreenPosition;
      gameRef.thuyTinh.position.y =
          bottomScreenPosition - gameRef.thuyTinh.height;
    }
  }
}
