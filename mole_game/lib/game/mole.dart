import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flame/events.dart';
import 'package:mole_game/functions/event_bus.dart'; // 이 줄을 추가해야 합니다.

class Mole extends PositionComponent with TapCallbacks {
  Mole({
    required super.position,
    required super.priority,
  });

  bool enableHit = false; // 때리는 것을 허용할지 여부

  SpriteComponent? mole;
  SpriteComponent? hitMole;

  @override
  void onLoad() async {
    addMole();
  }

  void addMole() async {
    String spriteFileName = 'mole_normal.png';
    Sprite sprite = await Sprite.load(spriteFileName);
    size = Vector2(230, 230 * 1.33);
    mole = SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: Anchor.topLeft,
    );
    add(mole!);

    spriteFileName = 'mole_hit.png';
    sprite = await Sprite.load(spriteFileName);
    hitMole = SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: Anchor.topLeft,
    );
    add(hitMole!);
    hitMole?.opacity = 0;
    anchor = Anchor.center;

    actionSequence();
  }

  void actionSequence() async {
    hitMole?.opacity = 0;
    mole?.opacity = 1;
    //아래는 원래 만들었던 코드
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

  //Mole 클래스
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (enableHit == true) {
      hitMole?.opacity = 1;
      mole?.opacity = 0;
      enableHit = false;
      EventBus().publish(plusScoreEvent, 1);
    }

    event.handled = true;
  }
}
