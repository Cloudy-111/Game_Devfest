import 'dart:async';

import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/collision_block.dart';
import 'package:first_flutter_prj/components/player_hitbox.dart';
import 'package:first_flutter_prj/components/utils.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum PlayerState { idle, running, jumping, falling } // trang thai cua player

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<JumpKing>, KeyboardHandler {
  String character;
  Player({
    position,
    this.character = 'Pink Man',
  }) : super(position: position);
  //constructor nhan 1 chuoi, thuoc tinh position duoc ke thua tu lop cha

  final double stepTime = 0.05; // là tốc độ game
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  DateTime? pressTime;
  int dur = 1;

  final double _gravity = 10;
  final double _limitVelocityPositive = 1000;
  final double _limitVelocityNegative = 400;
  final double _jumpForce = 100;
  bool isOnGround = false;
  bool hasJumped = false;

  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  List<CollisionBlock> lstCollisionBlock = [];
  PlayerHitbox hitbox = PlayerHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );

  void startSpaceHold() {
    pressTime = DateTime.now();
  }

  int endSpaceHold() {
    if (pressTime != null) {
      DateTime endTime = DateTime.now();
      Duration duration = endTime.difference(pressTime!);
      return duration.inMilliseconds;
    }
    return 0; // Trường hợp không có sự kiện nhấn giữ Space
  }

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation(); // _method tuc method la private
    debugMode = false;
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // dt(deltaTime) la khoang thoi gian giua 2 frame lien tiep, duoc set tu dong boi framework
    _updatePlayerState();
    _updateMovementPlayer(dt);
    _checkHorizontalCollision();
    _applyGravity(dt);
    _checkVerticalCollision();
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    final isLeftKey = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKey = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKey ? -1 : 0;
    horizontalMovement += isRightKey ? 1 : 0;

    //hasJumped = keysPressed.contains(LogicalKeyboardKey.space);

    if (event is RawKeyUpEvent &&
        event.logicalKey == LogicalKeyboardKey.space) {
      hasJumped = true;
      // Người dùng đã nhả phím Space
      print("Thời gian nhấn Space: $pressTime ms");
      DateTime end = DateTime.now();
      print("Thời gian thả Space: $end ms");
      Duration duration = end.difference(pressTime!);
      dur = duration.inMilliseconds;
      if (dur > 0) {
        print("Thời gian nhấn giữ Space: $dur ms");
      }
      pressTime = null;
    } else if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.space &&
        pressTime == null) {
      // Người dùng đã nhấn phím Space
      pressTime = DateTime.now();
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimation() {
    //idleAnimation
    idleAnimation = _spriteAnimation('Idle', 11);

    //runningAnimation
    runningAnimation = _spriteAnimation('Run', 12);

    //fallingAnimation
    fallingAnimation = _spriteAnimation('Fall', 1);

    //jumpingAnimation
    jumpingAnimation = _spriteAnimation('Jump', 1);

    // tao cac animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
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

  void _updateMovementPlayer(double dt) {
    if (hasJumped && isOnGround) _playerJump(dt);

    //if (velocity.y > _gravity) isOnGround = true;

    velocity.x = horizontalMovement *
        moveSpeed; //van toc cua object(+ hay - la di sang trai hoac phai)
    position.x += velocity.x *
        dt; //vi tri moi = velocity * deltaTime (la 1 vector2, the hien toa do cua object)
  }

  void _playerJump(double dt) {
    velocity.y = -_jumpForce * (dur / 500 > 1 ? dur / 500 : 1);
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;
    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    if (velocity.x != 0 || horizontalMovement != 0)
      playerState = PlayerState.running;

    if (velocity.y > 0) playerState = PlayerState.falling;
    if (velocity.y < 0) playerState = PlayerState.jumping;
    current = playerState;
  }

  void _checkHorizontalCollision() {
    //tuy chinh collision
    for (final block in lstCollisionBlock) {
      if (!block.isPlatform) {
        if (checkCollision(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.width - hitbox.offsetX;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y =
        velocity.y.clamp(-_limitVelocityNegative, _limitVelocityPositive);
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollision() {
    for (final block in lstCollisionBlock) {
      if (!block.isPlatform) {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height - hitbox.offsetY;
            break;
          }
        }
      } else {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
        }
      }
    }
  }
}
