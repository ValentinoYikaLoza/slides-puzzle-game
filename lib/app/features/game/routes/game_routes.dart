import 'package:gambling_game/app/features/game/screens/game_screen.dart';
import 'package:go_router/go_router.dart';

class GameRoutes {
  static GoRoute game = GoRoute(
    path: '/game/:level', // Acepta un parámetro `level`
    builder: (context, state) {
      final level = int.parse(state.pathParameters['level']!); // Obtén el nivel
      return GameScreen(level: level); // Pasa el nivel a GameScreen
    },
  );
}
