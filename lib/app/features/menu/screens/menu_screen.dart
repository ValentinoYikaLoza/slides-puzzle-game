import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';
import 'package:gambling_game/app/features/shop/routes/shop_routes.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
                  'Slide Puzzle',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 48,
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
                // Play Button
                MenuButton(
                  icon: Icons.play_arrow,
                  label: 'Play',
                  onPressed: () {
                    // Play sound effect
                    // playSound('button_click.mp3');
                    AppRouter.push(MenuRoutes.levelSelector.path);
                  },
                ),
                const SizedBox(height: 20),
                // Shop Button
                MenuButton(
                  icon: Icons.shopping_cart,
                  label: 'Shop',
                  onPressed: () {
                    // Play sound effect
                    // playSound('button_click.mp3');
                    AppRouter.push(ShopRoutes.shop.path);
                  },
                ),
                const SizedBox(height: 20),
                // Premium Shop Button
                MenuButton(
                  icon: Icons.attach_money,
                  label: 'Premium Shop',
                  onPressed: () {
                    AppRouter.push(ShopRoutes.realshop.path);
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

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: AnimatedContainer(
        duration: const Duration(seconds: 10),
        curve: Curves.linear,
        onEnd: () {
          // Restart the animation
        },
        child: CustomPaint(
          painter: BackgroundPainter(),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade300.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw puzzle piece shapes
    for (int i = 0; i < 10; i++) {
      final x = size.width * (i / 10);
      final y = size.height * (i / 10);
      canvas.drawCircle(Offset(x, y), 500, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue.shade800, size: 24),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
