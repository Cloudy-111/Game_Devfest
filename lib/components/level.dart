import 'dart:async';
import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/collision_block.dart';
import 'package:first_flutter_prj/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with ParentIsA<JumpKing> {
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});
  late TiledComponent level;
  List<CollisionBlock> lstCollisionBlock = []; //dung de chua cac collitionBlock

  bool isGameInit = false;

  @override
  void update(double dt) {
    _updateCamera();
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
        '$levelName.tmx', Vector2.all(16)); //kich co moi o cua man hinh game

    add(level);

    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('SpawnPoint');

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

  void _updateCamera() {
    if (!isGameInit) {
      parent.cam.moveTo(Vector2(
          parent.gameResolution.x / 2,
          parent.gameResolution.y -
              (parent.gameResolution.y / parent.splitRate / 2)));
      isGameInit = true;
    }

    if (player.velocity.y < 0 &&
        parent.cam.viewfinder.position.y > player.position.y) {
      parent.cam.moveTo(Vector2(parent.gameResolution.x / 2, player.position.y),
          speed: 200);
    }
  }
}
