import 'package:flutter_riverpod/flutter_riverpod.dart';

final levelProvider = StateNotifierProvider<LevelNotifier, LevelState>((ref) {
  return LevelNotifier(ref);
});

class LevelNotifier extends StateNotifier<LevelState> {
  LevelNotifier(this.ref) : super(LevelState());

  final Ref ref;

  void levelUp(int currentLevel) {
    if (currentLevel < state.levelNumbersUnlocked) return;
    state = state.copyWith(
      levelNumbersUnlocked: state.levelNumbersUnlocked + 1,
    );
  }

  bool isLevelComplete(int currenLevel) {
    return state.levelNumbersUnlocked > currenLevel;
  }
}

class LevelState {
  final int levelNumbersUnlocked;
  final int totalLevelNumbers;

  LevelState({
    this.levelNumbersUnlocked = 1,
    this.totalLevelNumbers = 100,
  });

  LevelState copyWith({
    int? levelNumbersUnlocked,
    int? totalLevelNumbers,
  }) {
    return LevelState(
      levelNumbersUnlocked: levelNumbersUnlocked ?? this.levelNumbersUnlocked,
      totalLevelNumbers: totalLevelNumbers ?? this.totalLevelNumbers,
    );
  }
}
