import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';
import 'package:gambling_game/app/features/menu/widgets/animated_background.dart';
import 'package:gambling_game/app/features/menu/widgets/custom_button.dart';

class TypeSelectorScreen extends StatelessWidget {
  const TypeSelectorScreen({super.key});

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
                Text(
                  'Choose Puzzle Type',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 36,
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
                const SizedBox(height: 40),
                // Image Puzzle Button
                CustomButton(
                  icon: Icons.image,
                  label: 'Image Puzzle',
                  onPressed: () {
                    AppRouter.push(MenuRoutes.levelSelector.path);
                  },
                ),
                const SizedBox(height: 20),
                // Number Puzzle Button
                CustomButton(
                  icon: Icons.numbers,
                  label: 'Number Puzzle',
                  onPressed: () {
                    AppRouter.push(MenuRoutes.levelSelector.path);
                  },
                ),
                const SizedBox(height: 20),
                // Other Puzzle Button
                CustomButton(
                  icon: Icons.extension,
                  label: 'Other Puzzle',
                  onPressed: () {
                    AppRouter.push(MenuRoutes.levelSelector.path);
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
