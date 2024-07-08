import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:mole_game/game/star_effect.dart';

class Hammer extends PositionComponent with TapCallbacks {
  Hammer({
    required super.priority,
  }) {
    width = 1080;
    height = 1920;
  }

  SpriteComponent? _hammerSpriteComponent;
  Sprite? _hammerSprite;
  StartEffect? _starEffect;

  @override
  void onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    _hammerSprite = await Sprite.load('hammer.png');
    _starEffect = StartEffect(priority: priority + 1);
    add(_starEffect!);
  }

  SpriteComponent _makeHammer() {
    _hammerSpriteComponent?.removeFromParent();

    _hammerSpriteComponent =
        SpriteComponent(sprite: _hammerSprite, size: Vector2(200, 200));
    _hammerSpriteComponent!.opacity = 0;
    _hammerSpriteComponent!.anchor = Anchor.bottomCenter;
    return _hammerSpriteComponent!;
  }

  void _hitHammer(Vector2 position) {
    SpriteComponent hammer = _makeHammer();
    add(hammer);
    hammer.position = position;
    OpacityEffect fadeIn = OpacityEffect.to(
      1.0,
      EffectController(duration: 0.25),
    );
    RotateEffect rotateEffect = RotateEffect.to(
      -tau / 3.0,
      EffectController(duration: 0.05, infinite: false),
    );
    OpacityEffect fadeOut = OpacityEffect.to(
      0.0,
      EffectController(duration: 0.25),
    );
    SequenceEffect sequence = SequenceEffect([fadeIn, rotateEffect, fadeOut]);
    hammer.add(sequence);
  }

  @override
  bool onTapDown(TapDownEvent event) {
    _hitHammer(event.localPosition + Vector2(150, 0));
    _hammerSpriteComponent!.position = event.localPosition + Vector2(150, 0);
    _starEffect!.hitStar(event.localPosition);
    event.continuePropagation = true;
    return false;
  }
}
