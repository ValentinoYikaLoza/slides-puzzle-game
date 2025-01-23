import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final double width;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
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
              if (icon != null)
                Icon(icon, color: Colors.blue.shade800, size: 24),
              if (icon != null) const SizedBox(width: 10),
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
