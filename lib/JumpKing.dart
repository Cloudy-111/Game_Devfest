import 'dart:async';
import 'dart:ui';
import 'package:first_flutter_prj/components/enemy.dart';
import 'package:first_flutter_prj/components/saw.dart';
import 'package:flame/palette.dart';

import 'main.dart';

import 'package:first_flutter_prj/components/Goal.dart';
import 'package:first_flutter_prj/components/jump_button.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:first_flutter_prj/components/level.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';

class JumpKing extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  //HasKeyboardHandlerComponents phai co de nhan dieu khien tu ban phim
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'SonTinh');
  Goal goal = Goal(character: 'Virtual Guy');
  Enemy thuyTinh = Enemy();
  late JoystickComponent joyStick;
  bool showJoystick = false; //hien joystick khi la mobile, an khi la desktop
  bool playSound = false; // bug của flutter với windows, bắt buộc có
  double soundVolume = 1.0;
  TextComponent attemp = TextComponent();
  final gameResolution = Vector2(368, 640);

  @override
  FutureOr<void> onLoad() async {
    final textStyle = TextStyle(
        color: BasicPalette.white.color, fontSize: 30, fontFamily: 'Karma');
    attemp.priority = 5;
    attemp
      ..text = 'Attempts: 1'
      ..textRenderer = TextPaint(
        style: textStyle,
      )
      ..position = Vector2(120, 600);
    player.onAttemptsChanged = (attemps) {
      attemp..text = 'Attempts: $attemps';
    };
    add(attemp);

    await images.loadAllImages();
    final screen = Level(
        player: player, levelName: 'level-1', goal: goal, thuyTinh: thuyTinh);

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

  String _updateAttemp() {
    return Player().attemps.toString();
  }

  void onLose() {
    overlays.add('gameOverOverlay');
  }

  void resetGame() {
    overlays.remove('winOverlay');
    overlays.remove('gameOverOverlay');
  }

  void onWin() {
    overlays.add('winOverlay');
  }
}
