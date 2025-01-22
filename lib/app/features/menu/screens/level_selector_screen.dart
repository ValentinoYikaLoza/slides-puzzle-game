import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/game/routes/game_routes.dart';
import 'package:gambling_game/app/features/menu/providers/level_provider.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';

class LevelSelectorScreen extends ConsumerWidget {

  const LevelSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelState = ref.watch(levelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        surfaceTintColor: Colors.blue.shade50,
        title: Text(
          'Slide Puzzle Levels',
          style: TextStyle(
            color: Colors.blue.shade800,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(2, 2),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue.shade800,
              size: 40,
            ),
          ),
          onPressed: () {
            AppRouter.go(MenuRoutes.menu.path);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.green.shade50
            ], // Light pastel gradient
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // Number of columns in the grid
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: levelState.totalLevelNumbers,
                  itemBuilder: (context, index) {
                    int levelNumber = index + 1;
                    bool isLocked = levelNumber > levelState.levelNumbersUnlocked;
                    return PuzzleTile(
                      levelNumber: levelNumber,
                      isLocked: isLocked,
                      onPressed: () {
                        if (!isLocked) {
                          AppRouter.push('${GameRoutes.game.path}/$levelNumber'
                              .replaceAll(':level/', ''));
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzleTile extends StatelessWidget {
  final int levelNumber;
  final bool isLocked;
  final VoidCallback onPressed;

  const PuzzleTile({
    super.key,
    required this.levelNumber,
    required this.isLocked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isLocked ? Colors.grey.shade400 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: isLocked ? Colors.grey.shade600 : Colors.blue.shade300,
            width: 2,
          ),
        ),
        child: Center(
          child: isLocked
              ? const Icon(Icons.lock, color: Colors.white, size: 24)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.grid_on,
                        color: Colors.blue.shade800,
                        size: 24), // Grid icon for slide puzzle
                    const SizedBox(height: 5),
                    Text(
                      '$levelNumber',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
