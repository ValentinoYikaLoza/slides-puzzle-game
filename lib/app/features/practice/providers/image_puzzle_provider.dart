import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePuzzleState {
  final List<int> numbers;
  final int gridSize;

  ImagePuzzleState({
    this.numbers = const [1, 2, 3, 4, 5, 6, 7, 8, 0],
    this.gridSize = 3,
  });

  ImagePuzzleState copyWith({
    List<int>? numbers,
    int? gridSize,
  }) {
    return ImagePuzzleState(
      numbers: numbers ?? this.numbers,
      gridSize: gridSize ?? this.gridSize,
    );
  }
}

class ImagePuzzleStateNotifier extends StateNotifier<ImagePuzzleState> {
  ImagePuzzleStateNotifier() : super(ImagePuzzleState());

  void moveNumber(int index) {
    if (isOrdered()) {
      return;
    }
    if (_canMoveNumber(index)) {
      _swapNumbers(index);
    }
  }

  bool _canMoveNumber(int index) {
    int emptyIndex = state.numbers.indexOf(0);
    return isAdjacent(index, emptyIndex);
  }

  void _swapNumbers(int index) {
    int emptyIndex = state.numbers.indexOf(0);
    final newNumbers = [...state.numbers];
    newNumbers[emptyIndex] = state.numbers[index];
    newNumbers[index] = 0;
    state = state.copyWith(numbers: newNumbers);
  }

  void disorderNumbers() {
    _shuffleNumbers();
  }

  void _shuffleNumbers() {
    final shuffledNumbers = [...state.numbers]..shuffle(Random());
    while (!_isSolvable(shuffledNumbers)) {
      shuffledNumbers.shuffle(Random());
    }
    state = state.copyWith(
      numbers: shuffledNumbers,
    );
  }

  void orderNumbers() {
    final orderedNumbers = List<int>.generate(
        state.gridSize * state.gridSize - 1, (index) => index + 1)
      ..add(0);
    state = state.copyWith(numbers: orderedNumbers);
  }

  void resetState() {
    state = ImagePuzzleState();
  }

  bool isOrdered() {
    final numbers = state.numbers;
    for (int i = 0; i < numbers.length - 1; i++) {
      if (numbers[i] != i + 1) {
        return false;
      }
    }

    return numbers.last == 0;
  }

  bool isAdjacent(int index1, int index2) {
    if (index1 == index2) return false;
    final gridSize = state.gridSize;
    return (index1 % gridSize != 0 && index1 - 1 == index2) ||
        (index1 % gridSize != gridSize - 1 && index1 + 1 == index2) ||
        (index1 - gridSize == index2) ||
        (index1 + gridSize == index2);
  }

  bool _isSolvable(List<int> numbers) {
    int inversions = 0;
    int gridSize = state.gridSize;
    int emptyRow = 0;

    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i] == 0) {
        emptyRow = gridSize - (i ~/ gridSize);
      }
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[i] != 0 && numbers[j] != 0 && numbers[i] > numbers[j]) {
          inversions++;
        }
      }
    }

    if (gridSize % 2 != 0) {
      return inversions % 2 == 0;
    } else {
      return (inversions % 2 == 0) == (emptyRow % 2 != 0);
    }
  }

  void setGridSize(int size) {
    state = state.copyWith(
      gridSize: size,
      numbers: List<int>.generate(size * size - 1, (index) => index + 1)
        ..add(0),
    );
    disorderNumbers();
  }
}

final imagePuzzleProvider =
    StateNotifierProvider<ImagePuzzleStateNotifier, ImagePuzzleState>((ref) {
  return ImagePuzzleStateNotifier();
});
