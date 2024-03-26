import 'package:flutter/material.dart';
import 'package:jumpy_skater/game/assets.dart';
import 'package:jumpy_skater/game/jumpy_skater_game.dart';

class StartPage extends StatelessWidget {
  final JumpySkaterGame game;
  static const String id = 'startPageId';

  const StartPage({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        game.overlays.remove(StartPage.id);
        game.resumeEngine();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.startPageBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Tap to start!',
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontFamily: 'Game',
            ),
          ),
        ),
      ),
    ));
  }
}
