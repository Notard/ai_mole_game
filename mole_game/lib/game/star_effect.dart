import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class StartEffect extends PositionComponent {
  StartEffect({
    required super.priority,
  }) {
    width = 200;
    height = 200;
  }

  Sprite? _starSprite;
  SpriteComponent? _starSpriteComponent;

  @override
  void onLoad() async {
    super.onLoad();
    anchor = Anchor.topLeft;
    _starSprite = await Sprite.load('star_effect.png');
  }

  SpriteComponent _makeStar() {
    _starSpriteComponent?.removeFromParent();

    _starSpriteComponent =
        SpriteComponent(sprite: _starSprite, size: Vector2(200, 200));
    _starSpriteComponent!.opacity = 0;
    _starSpriteComponent!.anchor = Anchor.center;
    _starSpriteComponent!.scale = Vector2(0.5, 0.5);
    return _starSpriteComponent!;
  }

  void hitStar(Vector2 position) {
    SpriteComponent star = _makeStar();
    add(star);
    star.position = position;
    OpacityEffect fadeIn = OpacityEffect.to(
      1.0,
      EffectController(duration: 0.1),
    );
    OpacityEffect fadeOut = OpacityEffect.to(
      0.0,
      EffectController(duration: 0.1),
    );
    ScaleEffect scaleEffect = ScaleEffect.to(
      Vector2(1.5, 1.5),
      EffectController(duration: 0.15),
    );
    SequenceEffect sequence = SequenceEffect([fadeIn, fadeOut]);
    star.addAll([sequence, scaleEffect]);
  }
}
