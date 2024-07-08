import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mole_game/functions/event_bus.dart';
import 'package:mole_game/game/game_frame.dart';
import 'package:mole_game/game/game_over.dart';
import 'package:mole_game/game/game_success.dart';
import 'package:mole_game/game/gui/gui_base.dart';
import 'package:mole_game/game/hammer.dart';
import 'package:mole_game/game/mole_line.dart';

class GamePage extends PositionComponent {
  final int maxScore = 30;

  Hammer? hammer;
  @override
  Future<void> onLoad() async {
    SpriteComponent backgroundImage = SpriteComponent(
      sprite: await Sprite.load('mole_game_background.png'),
      size: Vector2(1080, 1920),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    add(backgroundImage);

    addMoleLine(740, 360, 1);
    addMoleLine(1080, 360, 2);
    addMoleLine(1420, 360, 3);

    hammer = Hammer(priority: 10);
    add(hammer!);

    GuiBase guiBase = GuiBase(priority: 100);
    add(guiBase);
    var a = children;

    EventBus().subscribe(nowScoreEvent, (int nowScore) {
      if (nowScore >= maxScore) {
        EventBus().publish(gameSuccessEvent, true);
      }
    });

    EventBus().subscribe(gameOverEvent, (_) {
      GameOver gameOver = GameOver(
          priority: 100,
          callPage: this,
          buttonText: '메인메뉴로',
          eventName: mainMenuEvent);
      add(gameOver);
    });
    //gameSuccessEvent
    EventBus().subscribe(gameSuccessEvent, (_) {
      GameSuccess gameSuccess = GameSuccess(
        priority: 100,
        callPage: this,
        buttonText: '메인메뉴로',
        eventName: mainMenuEvent,
      );
      add(gameSuccess);
    });
  }

  // 가로 한 줄을 추가하는 함수
  void addMoleLine(double yPos, double clipHeight, int priority) {
    MoleLine moleLine = MoleLine(
      priority: priority,
      clipHeight: clipHeight,
      spriteFileName: 'mole_game_background.png',
      yPos: yPos,
    );
    add(moleLine);
  }

  void addHole({required Vector2 position, required int priority}) async {
    String spriteFileName = 'hole.png';

    SpriteComponent hole = await loadHalfSprite(spriteFileName, true, position);
    hole.priority = priority;
    SpriteComponent hole2 =
        await loadHalfSprite(spriteFileName, false, position);
    hole.priority = priority;
    add(hole);
    add(hole2);
    addShadow(
        position: position + Vector2.all(30),
        priority: 9,
        spriteFileName: spriteFileName);
  }

  void addShadow(
      {required Vector2 position,
      required String spriteFileName,
      required int priority}) async {
    SpriteComponent shadow = SpriteComponent(
      sprite: await Sprite.load(spriteFileName),
      size: Vector2.all(350),
      position: position,
      anchor: Anchor.center,
    );
    shadow.paint = Paint()
      ..colorFilter = const ColorFilter.mode(Colors.black, BlendMode.modulate)
      ..color = Colors.black.withOpacity(0.5);
    add(shadow);
  }

  void addMole({required Vector2 position, required int priority}) async {
    String spriteFileName = 'mole_normal.png';

    SpriteComponent mole = SpriteComponent(
      sprite: await Sprite.load(spriteFileName),
      size: Vector2(320, 416),
      position: position,
      anchor: Anchor.center,
      priority: priority,
    );
    add(mole);
    addShadow(
        position: position + Vector2.all(30),
        priority: 9,
        spriteFileName: spriteFileName);
  }

  Future<SpriteComponent> loadHalfSprite(
      String spriteFileName, bool upperHalf, Vector2 position) async {
    Sprite sprite = await Sprite.load(spriteFileName);
    Vector2 size = sprite.srcSize;
    if (upperHalf == true) {
      sprite.srcPosition = Vector2(0, 0);
    } else {
      sprite.srcPosition = Vector2(0, size.y / 2);
    }
    sprite.srcSize = Vector2(size.x, size.y / 2);

    return SpriteComponent(
      sprite: sprite,
      size: Vector2(350, 175),
      position: position,
      anchor: Anchor.center,
    );
  }
}
