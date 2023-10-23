import 'package:first_flutter_prj/components/start_screen.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_prj/JumpKing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  //await Flame.device.setLandscape();

  // JumpKing game = JumpKing(); //hàm khởi tạo trong OOP
  // runApp(GameWidget(game: kDebugMode ? JumpKing() : game));
  runApp(MaterialApp(home: StartScreen()));
}

