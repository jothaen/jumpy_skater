import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:jumpy_skater/components/ground.dart';
import 'package:jumpy_skater/components/hydrant.dart';
import 'package:jumpy_skater/game/assets.dart';
import 'package:jumpy_skater/game/config.dart';
import 'package:jumpy_skater/game/jumpy_skater_game.dart';
import 'package:jumpy_skater/game/skater_state.dart';
import 'package:jumpy_skater/page/game_over_page.dart';

class Skater extends SpriteGroupComponent<SkaterState> with HasGameRef<JumpySkaterGame>, CollisionCallbacks {
  Skater();

  int score = 0;
  bool isJumping = false;

  @override
  Future<void> onLoad() async {
    final skaterNormal = await gameRef.loadSprite(Assets.skateNormal);
    final skaterUp = await gameRef.loadSprite(Assets.skateJumpUp);
    final skaterDown = await gameRef.loadSprite(Assets.skateJumpDown);

    size = Vector2(200, 160);
    position = Vector2(20, gameRef.size.y - Config.groundHeight - size.y);
    current = SkaterState.onTheGround;
    sprites = {
      SkaterState.onTheGround: skaterNormal,
      SkaterState.jumpingUp: skaterUp,
      SkaterState.fallingDown: skaterDown,
    };
    FlameAudio.bgm
      ..play(Assets.cruising, volume: 0.09)
      ..stop();

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.y < gameRef.size.y - Config.groundHeight - size.y) {
      position.y += Config.birdVelocity * dt;
    }
  }

  void jump() {
    if (isJumping) {
      return;
    }
    FlameAudio.bgm.stop();
    FlameAudio.play(Assets.ollie);
    isJumping = true;
    current = SkaterState.jumpingUp;
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () {
          current = SkaterState.fallingDown;
        },
      ),
    );
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Hydrant) {
      other.removeFromParent();
      _gameOver();
    } else if (other is Ground) {
      current = SkaterState.onTheGround;
      isJumping = false;
      FlameAudio.bgm.resume();
    }
  }

  void reset() {
    gameRef.gameSpeed = Config.initialGameSpeed;
    position = Vector2(20, gameRef.size.y - Config.groundHeight - size.y);
    current = SkaterState.onTheGround;
    score = 0;
  }

  void _gameOver() {
    FlameAudio.play(Assets.collision);
    FlameAudio.bgm.stop();
    gameRef.overlays.add(GameOverPage.id);
    gameRef.pauseEngine();
  }
}
