import 'package:gambling_game/app/features/menu/screens/challenge_selector_screen.dart';
import 'package:gambling_game/app/features/menu/screens/level_selector_screen.dart';
import 'package:gambling_game/app/features/menu/screens/menu_screen.dart';
import 'package:gambling_game/app/features/menu/screens/mode_selector_screen.dart';
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
  static GoRoute modeSelector = GoRoute(
    path: '/mode',
    builder: (context, state) => const ModeSelectorScreen(),
  );
  static GoRoute challengeSelector = GoRoute(
    path: '/challenges',
    builder: (context, state) => ChallengeScreen(),
  );
}
