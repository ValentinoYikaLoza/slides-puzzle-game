
import 'package:gambling_game/app/features/shop/screens/shop_selector_screen.dart';
import 'package:go_router/go_router.dart';

class ShopRoutes {
  static GoRoute shop = GoRoute(
    path: '/shop',
    builder: (context, state) => const ShopSelectorScreen(),
  );
}
