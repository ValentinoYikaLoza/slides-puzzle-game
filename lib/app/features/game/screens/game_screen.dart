import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/game/providers/puzzle_provider.dart';
import 'package:gambling_game/app/features/menu/providers/level_provider.dart';
import 'package:gambling_game/app/features/shared/widgets/snackbar.dart';

class GameScreen extends ConsumerStatefulWidget {
  final int level;

  const GameScreen({
    super.key,
    required this.level,
  });

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late int gridSize;
  @override
  void initState() {
    super.initState();
    gridSize = _determineGridSize(widget.level);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(puzzleProvider.notifier).setGridSize(gridSize);
      ref.read(puzzleProvider.notifier).disorderNumbers(widget.level);
    });
  }

  int _determineGridSize(int level) {
    if (level >= 15) return 5;
    if (level >= 4) return 4;
    return 3;
  }

  @override
  void didUpdateWidget(covariant GameScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level != widget.level) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(puzzleProvider.notifier).setGridSize(gridSize);
        ref.read(puzzleProvider.notifier).loadStateForLevel(widget.level);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final numbers = ref.watch(puzzleProvider).numbers;
    final provider = ref.read(puzzleProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        surfaceTintColor: Colors.blue.shade50,
        title: Text(
          'Level ${widget.level}',
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
            AppRouter.pop();
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
              Colors.green.shade50,
            ], // Light pastel gradient
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.blue.shade800,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                'Time: ${provider.formatTime()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.blue.shade800,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridSize,
                  ),
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        int emptyIndex = numbers.indexOf(0);
                        if (provider.isAdjacent(index, emptyIndex)) {
                          provider.moveNumber(index, widget.level);
                          if (provider.isOrdered()) {
                            SnackbarService.show('You won!',
                                type: SnackbarType.normal);
                            ref
                                .read(levelProvider.notifier)
                                .levelUp(widget.level);
                            Future.delayed(const Duration(milliseconds: 50),
                                () {
                              AppRouter.pop();
                            });
                          }
                          provider.saveStateForLevel(widget.level);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: numbers[index] == 0
                              ? Colors.white
                              : Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue.shade800,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            numbers[index] == 0
                                ? ''
                                : numbers[index].toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
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
