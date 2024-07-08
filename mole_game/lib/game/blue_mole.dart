import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:mole_game/game/mole_parent.dart';

class BlueMole extends MoleParent {
  BlueMole({
    required super.position,
    required super.priority,
  });

  @override
  void onLoad() async {
    plusScore = 2;
    addMole('mole_blue.png', 'mole_blue_hit.png');
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
        delay: 0.7,
        EffectController(duration: 0.3),
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
