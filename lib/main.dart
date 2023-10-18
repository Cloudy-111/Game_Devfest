import 'package:first_flutter_prj/JumpKing.dart';
import 'package:first_flutter_prj/components/start_screen.dart';
import 'package:first_flutter_prj/widgets/game_over_overlay.dart';
import 'package:first_flutter_prj/widgets/game_overlay.dart';
import 'package:first_flutter_prj/widgets/main_menu_overlay.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  //await Flame.device.setLandscape();

  JumpKing game = JumpKing(); //hàm khởi tạo trong OOP
  runApp(GameWidget(game: kDebugMode ? JumpKing() : game));
  runApp(MaterialApp(
    home: StartScreen(),
  )
      //const MyApp()
      );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'JumpKing',
//       themeMode: ThemeMode.dark,
//       theme: ThemeData(
//         colorScheme: ThemeData.light().colorScheme,
//         useMaterial3: true,
//       ),
//       darkTheme: ThemeData(
//         colorScheme: ThemeData.dark().colorScheme,
//         textTheme: Typography.blackMountainView,
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'JumpKing'),
//     );
//   }
// }

// final Game game = JumpKing();

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Center(
//         child: LayoutBuilder(builder: (context, constraints) {
//           return Container(
//             constraints: const BoxConstraints(
//               maxWidth: 800,
//               minWidth: 550,
//             ),
//             child: GameWidget(
//               game: game,
//               overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
//                 'gameOverlay': (context, game) => GameOverlay(game),
//                 'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
//                 'gameOverOverlay': (context, game) => GameOverOverlay(game),
//               },
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
