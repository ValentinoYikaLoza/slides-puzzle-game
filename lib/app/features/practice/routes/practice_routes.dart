
import 'package:gambling_game/app/features/practice/screens/puzzle_selector_screen.dart';
import 'package:go_router/go_router.dart';

class PracticeRoutes {
  static GoRoute practice = GoRoute(
    path: '/practice',
    builder: (context, state) => const PuzzleSelectorScreen(),
  );
}
