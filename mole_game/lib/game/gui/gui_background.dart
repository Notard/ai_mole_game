import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class GuiBackground extends PositionComponent {
  @override
  void onLoad() async {
    PositionComponent parentComponent = parent as PositionComponent;
    RectangleComponent rectangle = RectangleComponent(
      size: Vector2(parentComponent.width, 200),
      paint: BasicPalette.white.paint(),
    );
    add(rectangle);
  }
}
