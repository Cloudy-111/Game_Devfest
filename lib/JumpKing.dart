import 'dart:async';
import 'dart:ui';

import 'package:first_flutter_prj/components/jump_button.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:first_flutter_prj/components/level.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';

class JumpKing extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  //HasKeyboardHandlerComponents phai co de nhan dieu khien tu ban phim
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'Virtual Guy');
  late JoystickComponent joyStick;
  bool showJoystick = false; //hien joystick khi la mobile, an khi la desktop

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final screen = Level(
      player: player,
      levelName: 'level-portrait',
    );

    // cam = CameraComponent.withFixedResolution(
    //     world: screen, width: 360, height: 800);
    // cam.viewfinder.anchor = Anchor.topLeft;

    final gameResolution = Vector2(360, 800);

    cam = CameraComponent.withFixedResolution(
      world: screen,
      width: gameResolution.x,
      height: gameResolution.y / 2,
    );
    cam.viewfinder.position = gameResolution / 2;

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
}
