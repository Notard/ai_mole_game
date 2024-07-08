import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mole_game/game/game_frame.dart';

void main() {
  runApp(
    GameWidget(
      game: FlameGame(
        world: GameFrame(),
        camera: CameraComponent(
          viewport: FixedResolutionViewport(
            resolution: Vector2(1080, 1920),
          ),
        ),
      ),
    ),
  );
}
