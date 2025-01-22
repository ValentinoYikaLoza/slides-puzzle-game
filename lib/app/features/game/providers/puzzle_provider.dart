import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleState {
  final List<int> numbers;
  final int gridSize;
  final bool isPuzzleTouched;
  final bool isPuzzleComplete;
  final bool isTimerStarted;
  final Duration elapsedTime;

  PuzzleState({
    this.numbers = const [1, 2, 3, 4, 5, 6, 7, 8, 0],
    this.gridSize = 3,
    this.isPuzzleTouched = false,
    this.isPuzzleComplete = false,
    this.isTimerStarted = false,
    this.elapsedTime = Duration.zero,
  });

  PuzzleState copyWith({
    List<int>? numbers,
    int? gridSize,
    bool? isPuzzleTouched,
    bool? isPuzzleComplete,
    bool? isTimerStarted,
    Duration? elapsedTime,
  }) {
    return PuzzleState(
      numbers: numbers ?? this.numbers,
      gridSize: gridSize ?? this.gridSize,
      isPuzzleTouched: isPuzzleTouched ?? this.isPuzzleTouched,
      isPuzzleComplete: isPuzzleComplete ?? this.isPuzzleComplete,
      isTimerStarted: isTimerStarted ?? this.isTimerStarted,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}

class PuzzleStateNotifier extends StateNotifier<PuzzleState> {
  PuzzleStateNotifier(this.ref) : super(PuzzleState()) {
    startTimer();
  }

  final Ref ref;
  final Map<int, PuzzleState> _savedStates = {}; // Stores states for each level
  Timer? _playTimer;

  void startTimer() {
    _playTimer?.cancel();
    _playTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.isTimerStarted) {
        _updateElapsedTime();
      }
    });
  }

  void _updateElapsedTime() {
    state = state.copyWith(
      elapsedTime: state.elapsedTime + const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _playTimer?.cancel();
    super.dispose();
  }

  void moveNumber(int index, int currentLevel) {
    if (_canMoveNumber(index, currentLevel)) {
      _swapNumbers(index);
      state = state.copyWith(isTimerStarted: true);
    }
  }

  bool _canMoveNumber(int index, int currentLevel) {
    int emptyIndex = state.numbers.indexOf(0);
    return isAdjacent(index, emptyIndex) && !state.isPuzzleComplete;
  }

  void _swapNumbers(int index) {
    int emptyIndex = state.numbers.indexOf(0);
    final newNumbers = [...state.numbers];
    newNumbers[emptyIndex] = state.numbers[index];
    newNumbers[index] = 0;
    state = state.copyWith(numbers: newNumbers);
  }

  void disorderNumbers(int currentLevel) {
    if (_shouldLoadState(currentLevel)) {
      loadStateForLevel(currentLevel);
      return;
    }

    _shuffleNumbers();
    saveStateForLevel(currentLevel);
  }

  bool _shouldLoadState(int currentLevel) {
    return state.isPuzzleComplete || state.isPuzzleTouched;
  }

  void _shuffleNumbers() {
    final shuffledNumbers = [...state.numbers]..shuffle(Random());
    while (!_isSolvable(shuffledNumbers)) {
      shuffledNumbers.shuffle(Random());
    }
    state = state.copyWith(
      numbers: shuffledNumbers,
      isPuzzleTouched: true,
      isPuzzleComplete: false,
      isTimerStarted: false,
      elapsedTime: Duration.zero,
    );
  }

  void saveStateForLevel(int level) {
    _savedStates[level] = state;
  }

  void loadStateForLevel(int level) {
    state = _savedStates[level] ?? PuzzleState();
  }

  void resetState() {
    state = PuzzleState();
  }

  bool isOrdered() {
    if (!state.isPuzzleTouched || state.isPuzzleComplete) {
      return false;
    }

    final numbers = state.numbers;
    for (int i = 0; i < numbers.length - 1; i++) {
      if (numbers[i] != i + 1) {
        return false;
      }
    }

    state = state.copyWith(
      isPuzzleTouched: false,
      isPuzzleComplete: true,
      isTimerStarted: false,
    );

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

  String formatTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(state.elapsedTime.inMinutes.remainder(60));
    final seconds = twoDigits(state.elapsedTime.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void setGridSize(int size) {
    state = state.copyWith(
      gridSize: size,
      numbers: List<int>.generate(size * size - 1, (index) => index + 1)
        ..add(0),
    );
  }
}

final puzzleProvider =
    StateNotifierProvider<PuzzleStateNotifier, PuzzleState>((ref) {
  return PuzzleStateNotifier(ref);
});
