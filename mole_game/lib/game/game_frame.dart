import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:mole_game/functions/event_bus.dart';
import 'package:mole_game/game/game_main_menu.dart';
import 'package:mole_game/game/game_page.dart';
import 'package:mole_game/game/title_page.dart';

class GameFrame extends World {
  @override
  void onLoad() async {
    EventBus().subscribe(mainMenuEvent, (_) {
      add(GameMainPage());
    });

    EventBus().subscribe(gameStartEvent, (_) {
      add(GamePage());
    });

    add(TitlePage());
    return super.onLoad();
  }
}
