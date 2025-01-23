import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onPressed;
  const CustomAppbar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade50,
      surfaceTintColor: Colors.blue.shade50,
      title: SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                onPressed ?? AppRouter.go(MenuRoutes.menu.path);
              },
              icon: Icon(
                Icons.chevron_left,
                size: 40,
                color: Colors.blue.shade800,
                textDirection: TextDirection.ltr,
              ),
            ),
            const Spacer(),
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
