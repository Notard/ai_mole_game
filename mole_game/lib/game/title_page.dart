import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:mole_game/component/paint_text_component.dart';
import 'package:mole_game/functions/event_bus.dart';

class TitlePage extends PositionComponent {
  Future<SpriteComponent> makeLogo() async {
    Sprite sprite = await Sprite.load('logo.png');
    return SpriteComponent(
      sprite: sprite,
      size: Vector2.all(1080),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
  }

  Future<PaintTextComponent> makeTitleText() async {
    return PaintTextComponent(
      position: Vector2(0, 230),
      text: '두더지 잡기 게임',
      style: const TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
        fontSize: 126,
        fontFamily: '온글잎 은별',
        shadows: [
          Shadow(
            color: Colors.white,
            offset: Offset(2, 2),
            blurRadius: 10,
          ),
        ],
      ),
      anchor: Anchor.center,
    );
  }

  void setFadeEffect(PositionComponent component) {
    OpacityEffect fadeIn = OpacityEffect.to(
      1.0,
      EffectController(duration: 0.4),
    );

    OpacityEffect fadeOut = OpacityEffect.to(
      0.0,
      DelayedEffectController(
        delay: 0.1,
        EffectController(duration: 0.4),
      ),
    );
    SequenceEffect fadeInOutSequence = SequenceEffect([fadeIn, fadeOut]);
    component.add(fadeInOutSequence);
    fadeOut.onComplete = () {
      removeFromParent();
      EventBus().publish(mainMenuEvent, this);
    };
  }

  @override
  Future<void> onLoad() async {
    SpriteComponent spriteComponent = await makeLogo();
    spriteComponent.opacity = 0;
    PaintTextComponent titleText = await makeTitleText();
    add(spriteComponent);
    add(titleText);
    titleText.opacity = 0;
    setFadeEffect(spriteComponent);
    setFadeEffect(titleText);
    return super.onLoad();
  }
}
