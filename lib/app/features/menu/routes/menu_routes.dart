import 'package:gambling_game/app/features/menu/screens/level_selector_screen.dart';
import 'package:gambling_game/app/features/menu/screens/menu_screen.dart';
import 'package:go_router/go_router.dart';

class MenuRoutes {
  static GoRoute menu = GoRoute(
    path: '/menu',
    builder: (context, state) => const MenuScreen(),
  );
  static GoRoute levelSelector = GoRoute(
    path: '/levels',
    builder: (context, state) => const LevelSelectorScreen(),
  );
}
