import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  //class nay de nhan biet tuong va cac khoi khong di duoc, bi chan
  bool isPlatform;
  CollisionBlock({
    position,
    size,
    this.isPlatform = false, //platform la block co the di xuyen qua tu duoi len
  }) : super(
          position: position,
          size: size,
        ) {
    debugMode = false;
  }
}
