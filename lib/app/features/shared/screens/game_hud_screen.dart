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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
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

          // // Level Display
          // Row(
          //   children: [
          //     Icon(
          //       Icons.star,
          //       color: Colors.blue.shade800,
          //       size: 24,
          //     ),
          //     SizedBox(width: 8),
          //     Text(
          //       'Level 5',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.blue.shade800,
          //         fontFamily: 'Poppins',
          //       ),
          //     ),
          //   ],
          // ),

          // // Lives Display
          // Row(
          //   children: [
          //     Icon(
          //       Icons.favorite,
          //       color: Colors.red.shade400,
          //       size: 24,
          //     ),
          //     SizedBox(width: 8),
          //     Text(
          //       '3 Lives',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.blue.shade800,
          //         fontFamily: 'Poppins',
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
