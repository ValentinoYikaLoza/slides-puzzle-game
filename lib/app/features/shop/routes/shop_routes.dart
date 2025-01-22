
import 'package:gambling_game/app/features/shop/screens/real_shop_screen.dart';
import 'package:gambling_game/app/features/shop/screens/shop_screen.dart';
import 'package:go_router/go_router.dart';

class ShopRoutes {
  static GoRoute shop = GoRoute(
    path: '/shop',
    builder: (context, state) => ShopScreen(),
  );
  static GoRoute realshop = GoRoute(
    path: '/real-shop',
    builder: (context, state) => PremiumShopScreen(),
  );
}
