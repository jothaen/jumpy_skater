import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:jumpy_skater/game/assets.dart';
import 'package:jumpy_skater/game/config.dart';
import 'package:jumpy_skater/game/jumpy_skater_game.dart';
import 'package:jumpy_skater/utils/math_utils.dart';

class Money extends SpriteComponent with HasGameRef<JumpySkaterGame> {
  Money();

  @override
  FutureOr<void> onLoad() async {
    final image = await Flame.images.load(Assets.money);
    sprite = Sprite(image);
    size = Vector2(36, 36);
    anchor = Anchor.center;

    final positionY = MathUtils.randomValueFromRange(
      gameRef.size.y - 400,
      gameRef.size.y - size.y - Config.groundHeight,
    );
    position.y = positionY;
    position.x = gameRef.size.x;

    add(ScaleEffect.by(Vector2.all(2), EffectController(duration: 1, infinite: true, alternate: true)));
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= dt * gameRef.gameSpeed;
    if (position.x < -5) {
      removeFromParent();
    }
    super.update(dt);
  }
}
