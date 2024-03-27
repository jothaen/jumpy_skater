import 'package:flutter/material.dart';
import 'package:jumpy_skater/game/jumpy_skater_game.dart';

class GameOverPage extends StatelessWidget {
  final JumpySkaterGame game;

  static const String id = 'gameOverPageId';

  const GameOverPage({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _onRestart,
        child: Material(
          color: Colors.black38,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'Game',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Score: ${game.skater.score}',
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontFamily: 'Game',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tap to Retry',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontFamily: 'Game',
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _onRestart() {
    game.skater.reset();
    game.overlays.remove(GameOverPage.id);
    game.resumeEngine();
  }
}
