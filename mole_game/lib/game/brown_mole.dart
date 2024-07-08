import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:mole_game/game/mole_parent.dart';

class BrownMole extends MoleParent {
  BrownMole({
    required super.position,
    required super.priority,
  });

  @override
  void onLoad() async {
    plusScore = 1;
    addMole('mole_normal.png', 'mole_hit.png');
  }

  @override
  void actionSequence() {
    hitMole?.opacity = 0;
    mole?.opacity = 1;

    double randomTime = Random().nextDouble() * 5000 + 3000;

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
        delay: 1,
        EffectController(duration: 0.4),
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
