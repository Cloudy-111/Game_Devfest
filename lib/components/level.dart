import 'dart:async';
import 'dart:ui';
import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/collision_block.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<JumpKing> {
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});

  late TiledComponent level;
  List<CollisionBlock> lstCollisionBlock = []; //dung de chua cac collitionBlock

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
        '$levelName.tmx', Vector2.all(16)); //kich co moi o cua man hinh game

    add(level);

    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('SpawnPoint');

    _setupCamera();

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          default:
        }
      }
    }

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
    return super.onLoad();
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
