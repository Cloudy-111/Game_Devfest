import 'dart:async';
import 'dart:ui';
import 'package:flame/palette.dart';
import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/Goal.dart';
import 'package:first_flutter_prj/components/collision_block.dart';
import 'package:first_flutter_prj/components/moveBlock.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:first_flutter_prj/components/saw.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<JumpKing> {
  final String levelName;
  final Player player;
  final Goal goal;
  Level({
    required this.levelName,
    required this.player,
    required this.goal,
  });
  late TiledComponent level;
  List<CollisionBlock> lstCollisionBlock = []; //dung de chua cac collitionBlock

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
        '$levelName.tmx', Vector2.all(16)); //kich co moi o cua man hinh game

    add(level);
    _setupCamera();
    _spawningObject();
    _addCollision();

    return super.onLoad();
  }

  void _spawningObject() {
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('SpawnPoint');

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer!.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          case 'Saw':
            final offGoUp = spawnPoint.properties.getValue('offGoUp');
            final saw = Saw(
              offGoUp: offGoUp,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(saw);
            break;
          case 'Goal':
            goal.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(goal);
            break;
          default:
        }
      }
    }
  }

  void _addCollision() {
    final collisionLayer = level.tileMap.getLayer<ObjectGroup>('Collision');

    if (collisionLayer != null) {
      for (final collision in collisionLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height),
                isPlatform: true);
            lstCollisionBlock.add(platform);
            add(platform);
            break;
          case 'movePlatform':
            final isStatic = collision.properties.getValue('isStatic');
            final isVertical = collision.properties.getValue('isVertical');
            final offNeg = collision.properties.getValue('offNeg');
            final offPos = collision.properties.getValue('offPos');
            //final moveSpeed = collision.properties.getValue('moveSpeed');
            final platform = MoveBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isVertical: isVertical,
              isStatic: isStatic,
              offNeg: offNeg,
              offPos: offPos,
              //moveSpeed: moveSpeed,
            );
            lstCollisionBlock.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            lstCollisionBlock.add(block);
            add(block);
        }
      }
    }
    player.lstCollisionBlock = lstCollisionBlock;
  }

  void _setupCamera() {
    gameRef.cam.follow(player);
    gameRef.cam.setBounds(Rectangle.fromLTRB(
      gameRef.gameResolution.x / 2,
      gameRef.gameResolution.y / 2,
      level.width - gameRef.gameResolution.x / 2,
      level.height - gameRef.gameResolution.y / 2,
    ));
  }
}
