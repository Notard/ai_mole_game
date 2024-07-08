import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:mole_game/functions/event_bus.dart';

abstract class MoleParent extends PositionComponent with TapCallbacks {
  MoleParent({
    required super.position,
    required super.priority,
  });
  bool enableHit = false; // 때리는 것을 허용할지 여부

  SpriteComponent? mole;
  SpriteComponent? hitMole;
  int plusScore = 0;

  void actionSequence(); //가상함수.

  void addMole(String normalFileName, String hitFileName) async {
    Sprite sprite = await Sprite.load(normalFileName);
    size = Vector2(230, 230 * 1.33);
    mole = SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: Anchor.topLeft,
    );
    add(mole!);

    sprite = await Sprite.load(hitFileName);
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

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (enableHit == true) {
      hitMole?.opacity = 1;
      mole?.opacity = 0;
      enableHit = false;
      EventBus().publish(plusScoreEvent, plusScore);
    }

    event.handled = true;
  }
}
