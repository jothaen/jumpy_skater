import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:jumpy_skater/game/assets.dart';
import 'package:jumpy_skater/game/config.dart';
import 'package:jumpy_skater/game/jumpy_skater_game.dart';

class Hydrant extends SpriteComponent with HasGameRef<JumpySkaterGame> {
  Hydrant();

  @override
  Future<void> onLoad() async {
    final hydrant = await Flame.images.load(Assets.hydrant);

    sprite = Sprite(hydrant);
    size = Vector2(50, 110);
    position.y = gameRef.size.y - size.y - Config.groundHeight;
    position.x = gameRef.size.x;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= dt * gameRef.gameSpeed;

    if (position.x < -5) {
      removeFromParent();
      updateScore();
    }
    super.update(dt);
  }

  void updateScore() {
    gameRef.skater.score++;
    final sound = Random().nextBool() ? Assets.yeah : Assets.wow;
    FlameAudio.play(sound, volume: 0.5);
  }
}
