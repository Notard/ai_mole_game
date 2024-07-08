// import 'dart:ui';

// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';

// class MoleHole extends PositionComponent {
//   MoleHole({
//     required super.position,
//     required super.priority,
//     required this.spriteFileName,
//   });

//   final String spriteFileName;

//   @override
//   Future<void> onLoad() async {
//     size = Vector2(350, 350);
//     anchor = Anchor.center;
//     SpriteComponent upHole =
//         await loadHalfSprite(spriteFileName, true, Vector2.all(0), 1);

//     SpriteComponent downHole =
//         await loadHalfSprite(spriteFileName, false, Vector2(0, size.y / 2), 5);

//     add(upHole);
//     add(downHole);
//     addMole(position: Vector2(25, -10), priority: 3);
//     addShadow(
//         position: Vector2.all(30),
//         priority: 9,
//         size: Vector2.all(350),
//         spriteFileName: spriteFileName);

//     RectangleComponent rectangleComponent = RectangleComponent(
//       size: Vector2(350, 350),
//       position: Vector2(0, size.y - 100),
//     );

//     // rectangleComponent.setColor(Colors.white.withOpacity(0));
//     rectangleComponent.priority = 4;
//     add(rectangleComponent);
//   }

//   Future<SpriteComponent> loadHalfSprite(String spriteFileName, bool upperHalf,
//       Vector2 position, int priority) async {
//     Sprite sprite = await Sprite.load(spriteFileName);
//     Vector2 size = sprite.srcSize;
//     if (upperHalf == true) {
//       sprite.srcPosition = Vector2(0, 0);
//     } else {
//       sprite.srcPosition = Vector2(0, size.y / 2);
//     }
//     sprite.srcSize = Vector2(size.x, size.y / 2);

//     return SpriteComponent(
//       sprite: sprite,
//       size: Vector2(350, 175),
//       position: position,
//       anchor: Anchor.topLeft,
//       priority: priority,
//     );
//   }

//   void addShadow(
//       {required Vector2 position,
//       required String spriteFileName,
//       required Vector2 size,
//       required int priority}) async {
//     SpriteComponent shadow = SpriteComponent(
//       sprite: await Sprite.load(spriteFileName),
//       size: size,
//       position: position,
//       anchor: Anchor.topLeft,
//     );
//     shadow.paint = Paint()
//       ..colorFilter = const ColorFilter.mode(Colors.black, BlendMode.modulate)
//       ..color = Colors.black.withOpacity(0.5);
//     add(shadow);
//   }

//   void addMole({required Vector2 position, required int priority}) async {
//     String spriteFileName = 'mole_normal.png';

//     SpriteComponent mole = SpriteComponent(
//       sprite: await Sprite.load(spriteFileName),
//       size: Vector2(300, 450),
//       position: position,
//       anchor: Anchor.topLeft,
//       priority: priority,
//     );
//     add(mole);
//     addShadow(
//         position: position + Vector2.all(30),
//         priority: 9,
//         size: Vector2(300, 450),
//         spriteFileName: spriteFileName);
//   }
// }

