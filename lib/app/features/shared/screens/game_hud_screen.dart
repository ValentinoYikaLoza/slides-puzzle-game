import 'package:flutter/material.dart';
class GameHudScreen extends StatelessWidget {
  final Widget? child;
  const GameHudScreen({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child!,
        const GameHud(),
      ],
    );
  }
}

class GameHud extends StatelessWidget {
  const GameHud({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        
        children: [
          // Coins Display
          Row(
            children: [
              Icon(
                Icons.monetization_on,
                color: Colors.blue.shade800,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                '100 Coins',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
    
          // Level Display
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.blue.shade800,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Level 5',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
    
          // Lives Display
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red.shade400,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                '3 Lives',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HUDItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const HUDItem({super.key, 
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
