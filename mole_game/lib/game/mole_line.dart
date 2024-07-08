import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mole_game/game/blue_mole.dart';
import 'package:mole_game/game/brown_mole.dart';
import 'package:mole_game/game/mole_parent.dart';
import 'package:mole_game/game/red_mole.dart';

class MoleLine extends PositionComponent {
  MoleLine({
    required super.priority,
    required this.spriteFileName,
    required this.yPos,
    required this.clipHeight,
  });

  final String spriteFileName;
  final double yPos;
  final double clipHeight;
  final Vector2 holeSize = Vector2.all(350);

  @override
  Future<void> onLoad() async {
    Sprite sprite = await Sprite.load(spriteFileName);

    Vector2 size = sprite.srcSize;
    double imageYAspects = size.y / 1920;
    size = Vector2(size.x, clipHeight);

    sprite.srcSize = Vector2(size.x, clipHeight * imageYAspects);

    sprite.srcPosition = Vector2(0, yPos * imageYAspects);

    anchor = Anchor.topLeft;
    SpriteComponent cutImage = SpriteComponent(
      sprite: sprite,
      size: Vector2(1080, clipHeight),
    );
    position = Vector2(-540, yPos - 960);
    cutImage.priority = 4;
    add(cutImage);

    addHole(Vector2(20, 0));
    addHole(Vector2(370, 0));
    addHole(Vector2(720, 0));
  }

  void addHole(Vector2 holePosition) async {
    String spriteFileName = 'hole.png';
    Vector2 shadowPosition =
        Vector2(holePosition.x + 30, holePosition.y - holeSize.y / 2 + 30);
    SpriteComponent hole =
        await loadHalfSprite(spriteFileName, true, holePosition);

    SpriteComponent hole2 =
        await loadHalfSprite(spriteFileName, false, holePosition);

    add(hole);
    add(hole2);
    addShadowDown(
        shadowPosition: shadowPosition,
        priority: 2,
        holeFileName: spriteFileName,
        offsetY: 30);
    addShadowUp(
        shadowPosition: shadowPosition,
        priority: 2,
        holeFileName: spriteFileName,
        offsetY: 30);

    MoleParent? mole;
    Vector2 molePosition = Vector2(holePosition.x + holeSize.x / 2 + 10, 0);
    int molePriority = 3;

    int moleType = Random().nextInt(3);

    if (moleType == 0) {
      mole = RedMole(
        position: molePosition,
        priority: molePriority,
      );
    } else if (moleType == 1) {
      mole = BlueMole(
        position: molePosition,
        priority: molePriority,
      );
    } else if (moleType == 2) {
      mole = BrownMole(
        position: molePosition,
        priority: molePriority,
      );
    }
    add(mole!);
  }

  Future<SpriteComponent> loadHalfSprite(
      String spriteFileName, bool upperHalf, Vector2 holePosition) async {
    Sprite sprite = await Sprite.load(spriteFileName);
    Vector2 size = sprite.srcSize;
    double halfHeight = size.y / 2 + 1;
    double halfPosition = holeSize.y / 2;
    if (upperHalf == true) {
      sprite.srcPosition = Vector2(0, 0);
    } else {
      sprite.srcPosition = Vector2(0, halfHeight);
    }
    sprite.srcSize = Vector2(size.x, halfHeight);

    holePosition.y += upperHalf ? -halfPosition : halfPosition;

    return SpriteComponent(
      sprite: sprite,
      size: holeSize - Vector2(0, halfPosition),
      position: holePosition,
      anchor: Anchor.topLeft,
      priority: upperHalf ? 3 : 6,
    );
  }

  void addShadowDown({
    required Vector2 shadowPosition,
    required String holeFileName,
    required int priority,
    required double offsetY,
  }) async {
    Sprite sprite = await Sprite.load(holeFileName);
    final Vector2 shadowSize = Vector2(holeSize.x, holeSize.y / 2 + offsetY);
    final Vector2 shadowSpriteSize =
        Vector2(sprite.srcSize.x, sprite.srcSize.y / 2 + offsetY);
    sprite.srcPosition = Vector2(0, sprite.srcSize.y / 2 - offsetY);
    sprite.srcSize = shadowSpriteSize;
    SpriteComponent shadow = SpriteComponent(
      sprite: sprite,
      size: shadowSize,
      position: shadowPosition + Vector2(0, holeSize.y / 2 - offsetY),
      anchor: Anchor.topLeft,
      priority: 5,
    );
    shadow.paint = Paint()
      ..colorFilter = const ColorFilter.mode(Colors.black, BlendMode.modulate)
      ..color = Colors.black.withOpacity(0.5);
    add(shadow);
  }

  void addShadowUp({
    required Vector2 shadowPosition,
    required String holeFileName,
    required int priority,
    required double offsetY,
  }) async {
    Sprite sprite = await Sprite.load(holeFileName);
    final Vector2 shadowSize = Vector2(holeSize.x, holeSize.y / 2 - offsetY);
    final Vector2 shadowSpriteSize =
        Vector2(sprite.srcSize.x, sprite.srcSize.y / 2 - offsetY);
    sprite.srcPosition = Vector2(0, 0);
    sprite.srcSize = shadowSpriteSize;

    SpriteComponent shadow = SpriteComponent(
      sprite: sprite,
      size: shadowSize,
      position: shadowPosition + Vector2(0, offsetY),
      anchor: Anchor.topLeft,
      priority: 0,
    );
    shadow.paint = Paint()
      ..colorFilter = const ColorFilter.mode(Colors.black, BlendMode.modulate)
      ..color = Colors.black.withOpacity(0.5);
    add(shadow);
  }

  void addMole({
    required Vector2 position,
  }) async {
    String spriteFileName = 'mole_normal.png';

    SpriteComponent mole = SpriteComponent(
      sprite: await Sprite.load(spriteFileName),
      size: Vector2(230, 306),
      position: position,
      anchor: Anchor.center,
      priority: 3,
    );
    add(mole);
  }
}
