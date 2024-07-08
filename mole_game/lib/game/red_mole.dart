import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:mole_game/game/mole_parent.dart';

class RedMole extends MoleParent {
  RedMole({
    required super.position,
    required super.priority,
  });

  @override
  void onLoad() async {
    plusScore = 3;
    addMole('mole_red.png', 'mole_red_hit.png');
  }

  @override
  void actionSequence() {
    hitMole?.opacity = 0;
    mole?.opacity = 1;

    double randomTime = Random().nextDouble() * 8000 + 4000;

    MoveToEffect moveOutEffect = MoveToEffect(
      Vector2(position.x, position.y - 100),
      DelayedEffectController(
        delay: randomTime / 1000,
        EffectController(duration: 0.4),
      ),
    );
    moveOutEffect.onComplete = () {
      enableHit = true;
    };

    MoveToEffect moveInEffect = MoveToEffect(
      Vector2(position.x, position.y),
      DelayedEffectController(
        delay: 0.4,
        EffectController(duration: 0.1),
      ),
    );

    SequenceEffect moveEffect = SequenceEffect([moveOutEffect, moveInEffect]);
    moveEffect.onComplete = () {
      actionSequence();
      enableHit = false;
    };
    add(moveEffect);
  }
}
