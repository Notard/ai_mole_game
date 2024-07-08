import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:mole_game/component/game_rect_button.dart';
import 'package:mole_game/functions/event_bus.dart';
import 'package:mole_game/functions/game_function.dart';

class GameSuccess extends PositionComponent with TapCallbacks {
  final PositionComponent callPage;
  final String buttonText;
  final String eventName;
  GameSuccess({
    required super.priority,
    required this.callPage,
    required this.buttonText,
    required this.eventName,
  }) {
    anchor = Anchor.center;
    size = Vector2(1080, 1920);
    position = Vector2(0, 0);
  }

  @override
  void onLoad() async {
    String gameOverImage = 'game_success.png';
    final Sprite sprite = await Sprite.load(gameOverImage);
    Vector2 imageCompoentSize = sprite.originalSize;
    double aspectRatio = size.x / size.y;
    //width 는 960 픽셀
    imageCompoentSize = Vector2(960, 960 * aspectRatio);
    final SpriteComponent spriteComponent = SpriteComponent(
      sprite: sprite,
      size: imageCompoentSize,
      anchor: Anchor.center,
    );
    spriteComponent.position = Vector2(
      540,
      960,
    );
    add(spriteComponent);
    GameRectButton okButton = GameRectButton(
      spriteFileName: 'white_button.png',
      buttonSize: Vector2(500, 240),
      textComponent: TextComponent(
        text: buttonText,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: GameFunction().getTextStyle(
            fontSize: 90,
            color: Colors.indigo,
          ),
        ),
      ),
      onTapUpEvent: () {
        callPage.removeFromParent();
        callPage.parent = null;
        EventBus().publish(eventName);
      },
    );
    okButton.position = Vector2(540, 1500);
    add(okButton);
  }

  @override
  bool onTapUp(TapUpEvent event) {
    event.handled = true;
    return true;
  }

  @override
  bool onTapDown(TapDownEvent event) {
    event.handled = true;
    return true;
  }
}
