import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/StartScreen.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  //await Flame.device.setLandscape();

  // JumpKing game = JumpKing(); //hàm khởi tạo trong OOP
  // runApp(GameWidget(game: kDebugMode ? JumpKing() : game));
  runApp(MaterialApp(
    home: StartScreen(),
  ));
}
