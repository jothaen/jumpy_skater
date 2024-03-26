import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:jumpy_skater/components/background.dart';
import 'package:jumpy_skater/components/ground.dart';
import 'package:jumpy_skater/components/hydrant.dart';
import 'package:jumpy_skater/components/skater.dart';
import 'package:jumpy_skater/game/config.dart';

class JumpySkaterGame extends FlameGame with TapDetector, HasCollisionDetection {
  JumpySkaterGame();

  late Skater skater;
  Timer interval = Timer(Config.hydrantInterval, repeat: true);
  double gameSpeed = Config.initialGameSpeed;
  late TextComponent score;
  @override
  Future<void> onLoad() async {
    _init();
  }

  TextComponent buildScore() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
        ));
  }

  @override
  void onTap() {
    skater.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${skater.score}';
  }

  void _init() {
    addAll([
      Background(),
      Ground(),
      skater = Skater(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(Hydrant());
  }
}
