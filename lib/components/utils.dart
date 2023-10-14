bool checkCollision(player, block) {
  final hitbox = player.hitbox;
  final playerX = player.position.x + hitbox.offsetX;
  final playerY = player.position.y + hitbox.offsetY;
  final playerWidth = hitbox.width;
  final playerHeight = hitbox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixedX = player.scale.x < 0
      ? playerX - (hitbox.offsetX * 2) - playerWidth
      : playerX;
  //khi quay nguoc lai so voi huong mac dinh (dung flip), toa do bi sai nen phai dat lai toa do

  final fixedY = block.isPlatform ? playerY + playerHeight : playerY;
  //kiem tra xem den canh cua block hay chua
  // if (block.isPlatform) {
  //   return //fixedY < blockY + blockHeight &&
  //       fixedY < blockY &&
  //           fixedX < blockX + blockWidth &&
  //           fixedX + playerWidth > blockX;
  // } else {
  //   return playerY < blockY + blockHeight &&
  //       playerY + playerHeight > blockY &&
  //       fixedX < blockX + blockWidth &&
  //       fixedX + playerWidth > blockX;
  // }
  return (fixedY < blockY + blockHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX);
}
