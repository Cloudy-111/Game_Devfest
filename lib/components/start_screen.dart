import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/game_over_overlay.dart';
import 'package:first_flutter_prj/components/win_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/parallax.dart';
import 'package:flame/components.dart';

class StartScreen extends FlameGame  {
  
  late SpriteAnimationComponent menuFrame;
  
  @override

  void onLoad() async{
    super.onLoad();
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

    final menuFrameAnim = await loadSpriteAnimation(
        'HUD/Menu_anim (450x300).png',
      SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: 0.1,
          textureSize: Vector2(450, 300),
          amountPerRow: 12,
      )
    );

    menuFrame = SpriteAnimationComponent(
        animation: menuFrameAnim,
        position: Vector2(size.x/2, size.y*0.4),
        anchor: Anchor.center
    );

    add(menuFrame);

    add(SpriteComponent(
      size: Vector2(160, 100),
      sprite: await loadSprite('HUD/start_white.png'),
      position: Vector2(size.x/2, size.y*0.8),
      anchor: Anchor.bottomCenter
    ));
  }
}

