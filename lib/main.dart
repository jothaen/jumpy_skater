import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:jumpy_skater/game/jumpy_skater_game.dart';
import 'package:jumpy_skater/page/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'page/game_over_page.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  final game = JumpySkaterGame();
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: const [StartPage.id],
      overlayBuilderMap: {
        StartPage.id: (context, _) => StartPage(game: game),
        GameOverPage.id: (context, _) => GameOverPage(game: game),
      },
    ),
  );
}
