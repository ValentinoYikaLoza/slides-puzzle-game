import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';
import 'package:gambling_game/app/features/menu/widgets/animated_background.dart';
import 'package:gambling_game/app/features/menu/widgets/custom_button.dart';
import 'package:gambling_game/app/features/practice/routes/practice_routes.dart';
import 'package:gambling_game/app/features/shared/widgets/custom_title.dart';

class ModeSelectorScreen extends StatelessWidget {
  const ModeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          const AnimatedBackground(),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title with Shadow
                const CustomTitle(
                  title: 'Slide Puzzle',
                  fontSize: 48,
                ),
                const SizedBox(height: 40),
                // Image Puzzle Button
                CustomButton(
                  icon: Icons.star_outlined,
                  label: 'Practice',
                  onPressed: () {
                    AppRouter.go(PracticeRoutes.practice.path);
                  },
                ),
                const SizedBox(height: 20),
                // Number Puzzle Button
                CustomButton(
                  icon: Icons.star_outlined,
                  label: 'Levels',
                  onPressed: () {
                    AppRouter.go(MenuRoutes.levelSelector.path);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
