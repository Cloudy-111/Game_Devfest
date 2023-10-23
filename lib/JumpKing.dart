import 'dart:async';
import 'dart:ui';
import 'package:first_flutter_prj/components/saw.dart';
import 'package:flame/palette.dart';
import 'package:first_flutter_prj/components/Goal.dart';
import 'package:first_flutter_prj/components/jump_button.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:first_flutter_prj/components/level.dart';
import 'package:first_flutter_prj/components/enemy.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:flame/parallax.dart';

class JumpKing extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  //HasKeyboardHandlerComponents phai co de nhan dieu khien tu ban phim
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'SonTinh');
  Goal goal = Goal(character: 'MiNuong');
  Enemy thuyTinh = Enemy(character: 'ThuyTinh');
  Saw saw = Saw();
  late JoystickComponent joyStick;
  bool showJoystick = true; //hien joystick khi la mobile, an khi la desktop
  bool playSound = false; // bug của flutter với windows, bắt buộc có
  double soundVolume = 1.0;
  TextComponent attemp = TextComponent();
  final gameResolution = Vector2(368, 640);

  @override
  FutureOr<void> onLoad() async {
      final ParallaxComponent background = await loadParallaxComponent([
        ParallaxImageData('Background/layer-1.png'),
        ParallaxImageData('Background/layer-2.png'),
        ParallaxImageData('Background/layer-3.png'),
        ParallaxImageData('Background/layer-4.png'),
        ParallaxImageData('Background/layer-5.png'),
        ParallaxImageData('Background/layer-6.png'),
      ],
          fill: LayerFill.height,
          baseVelocity: Vector2(10, 0),
          velocityMultiplierDelta: Vector2(1.6, 1.0)
      );
      add(background);
    final textStyle = TextStyle(
        color: BasicPalette.white.color, fontSize: 25, fontFamily: 'Karma');
    attemp.priority = 5;
    attemp
      ..text = 'Attempts: 1'
      ..textRenderer = TextPaint(
        style: textStyle,
      )
      ..position = Vector2(10, 10);
    player.onAttemptsChanged = (attemps) {
      attemp.text = 'Attempts: $attemps';
    };
    player.onAttemptsReset = (attemps) {
      attemp.text = 'Attempts: $attemps';
    };
    add(attemp);

    await images.loadAllImages();
    final screen = Level(
      player: player,
      levelName: 'level-1',
      goal: goal,
      thuyTinh: thuyTinh,
      saw: saw,
    );

    cam = CameraComponent.withFixedResolution(
      world: screen,
      width: gameResolution.x,
      height: gameResolution.y,
    );
    //cam.viewfinder.anchor = Anchor.topLeft;
    cam.priority = 0; //dat la lop duoi cung(z-index = 0)
    addAll([cam, screen]);
    // add(Level());

    if (showJoystick) {
      addJoyStick(); //hien thi bang dieu khien tren mobile
      add(JumpButton());
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joyStick = JoystickComponent(
      priority: 1, //dat lop len tren (nhu z-index trong css)
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    add(joyStick);
  }

  void updateJoystick() {
    switch (joyStick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void onLose() {
    overlays.add('gameOverOverlay');
  }

  void resetGame() {
    overlays.remove('winOverlay');
    overlays.remove('gameOverOverlay');
    _resetSpritePosition();
  }

  void onWin() {
    overlays.add('winOverlay');
  }

  void _resetSpritePosition() {
    saw.position = Saw.startingPosition;
    thuyTinh.position = thuyTinh.startPosition;
  }
}
