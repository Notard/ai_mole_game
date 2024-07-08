import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:mole_game/component/number_display.dart';
import 'package:mole_game/functions/event_bus.dart';

class GuiBase extends PositionComponent {
  GuiBase({required super.priority});
  double _nowTime = 100;
  NumberDisplay? _scoreDisplay;
  NumberDisplay? _timeDisplay;
  int nowScore = 0;
  bool _isGameOver = false;
  @override
  void onLoad() async {
    super.onLoad();
    nowScore = 0;
    anchor = Anchor.topLeft;
    size = Vector2(1080, 1920);
    position = Vector2(0, 0);
    Paint whiteWidhOpacity = BasicPalette.black.paint();
    whiteWidhOpacity.color = whiteWidhOpacity.color.withOpacity(0.5);
    RectangleComponent rectangle = RectangleComponent(
      size: Vector2(1080, 200),
      paint: whiteWidhOpacity,
    );
    rectangle.anchor = Anchor.topCenter;
    rectangle.position = Vector2(0, -960);
    rectangle.priority = 1;
    add(rectangle);
    addTimeImage();
    addScoreImage();

    _scoreDisplay = NumberDisplay(position: Vector2(260, -880));
    _scoreDisplay?.priority = 2;
    add(_scoreDisplay!);
    _timeDisplay = NumberDisplay(position: Vector2(-260, -880));
    _timeDisplay?.priority = 2;
    add(_timeDisplay!);

    EventBus().subscribe(plusScoreEvent, (int addScore) {
      nowScore += addScore;
      _scoreDisplay?.setScore(nowScore);

      EventBus().publish(nowScoreEvent, nowScore);
    });
  }

  void addTimeImage() async {
    Sprite timeImage = await Sprite.load('time_image.png');
    double aspectRatio = timeImage.originalSize.x / timeImage.originalSize.y;
    SpriteComponent timeImageComponent = SpriteComponent(
      sprite: timeImage,
      size: Vector2(90 * aspectRatio, 90),
      position: Vector2(-520, -900),
    );
    timeImageComponent.priority = 2;
    timeImageComponent.anchor = Anchor.topLeft;
    add(timeImageComponent);
  }

  void addScoreImage() async {
    Sprite scoreImage = await Sprite.load('score_image.png');
    double aspectRatio = scoreImage.originalSize.x / scoreImage.originalSize.y;
    SpriteComponent scoreImageComponent = SpriteComponent(
      sprite: scoreImage,
      size: Vector2(90 * aspectRatio, 90),
      position: Vector2(0, -900),
    );
    scoreImageComponent.priority = 2;
    scoreImageComponent.anchor = Anchor.topLeft;
    add(scoreImageComponent);
  }

  @override
  void update(double dt) {
    _nowTime -= dt;
    if (_isGameOver == false) {
      _timeDisplay?.setScore(_nowTime.toInt());
    } else {
      _timeDisplay?.setScore(0);
      return;
    }
    if (_nowTime <= 0) {
      _nowTime = 0;
      _isGameOver = true;
      EventBus().publish(gameOverEvent);
    }
    super.update(dt);
  }
}
