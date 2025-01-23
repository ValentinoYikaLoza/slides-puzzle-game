import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:gambling_game/app/features/menu/widgets/custom_button.dart';
import 'package:gambling_game/app/features/practice/providers/image_puzzle_provider.dart';

class NumberPuzzleScreen extends ConsumerStatefulWidget {
  const NumberPuzzleScreen({super.key});

  @override
  NumberPuzzleScreenState createState() => NumberPuzzleScreenState();
}

class NumberPuzzleScreenState extends ConsumerState<NumberPuzzleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imagePuzzleProvider.notifier).disorderNumbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final puzzleState = ref.watch(imagePuzzleProvider);
    final provider = ref.read(imagePuzzleProvider.notifier);

    return Container(
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
          Row(
            children: [
              const Spacer(),
              CustomButton(
                icon: Icons.grid_on,
                width: 120,
                label: '3x3',
                onPressed: () {
                  provider.setGridSize(3);
                },
              ),
              const SizedBox(width: 8),
              CustomButton(
                icon: Icons.grid_on,
                label: '4x4',
                width: 120,
                onPressed: () {
                  provider.setGridSize(4);
                },
              ),
              const SizedBox(width: 8),
              CustomButton(
                icon: Icons.grid_on,
                label: '5x5',
                width: 120,
                onPressed: () {
                  provider.setGridSize(5);
                },
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 40),
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
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: puzzleState.gridSize,
                ),
                itemCount: puzzleState.numbers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      int emptyIndex = puzzleState.numbers.indexOf(0);
                      if (provider.isAdjacent(index, emptyIndex)) {
                        provider.moveNumber(index);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: puzzleState.numbers[index] == 0
                            ? Colors.white
                            : Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.blue.shade800,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          puzzleState.numbers[index] == 0
                              ? ''
                              : puzzleState.numbers[index].toString(),
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
          const SizedBox(height: 40),
          if (provider.isOrdered())
            CustomButton(
              icon: Icons.refresh,
              label: 'Shuffle',
              onPressed: () {
                provider.disorderNumbers();
              },
            ),
        ],
      ),
    );
  }
}
