import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String tittle;
  final Function()? onPressed;
  const CustomAppbar({super.key, required this.tittle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade50,
      surfaceTintColor: Colors.blue.shade50,
      title: Text(
        tittle,
        style: TextStyle(
          color: Colors.blue.shade800,
          fontSize: 28,
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
      leading: IconButton(
        icon: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(
            Icons.arrow_back,
            color: Colors.blue.shade800,
            size: 40,
          ),
        ),
        onPressed: onPressed ??
            () {
              AppRouter.pop();
            },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
