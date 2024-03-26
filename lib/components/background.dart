import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:jumpy_skater/game/assets.dart';
import 'package:jumpy_skater/game/jumpy_skater_game.dart';

class Background extends ParallaxComponent<JumpySkaterGame> with HasGameRef<JumpySkaterGame> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.backgorund);
    size = gameRef.size;

    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(background, fill: LayerFill.none, alignment: Alignment.center),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = gameRef.gameSpeed * 0.5;
  }
}
