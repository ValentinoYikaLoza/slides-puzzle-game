import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/game/routes/game_routes.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';
import 'package:gambling_game/app/features/shop/routes/shop_routes.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        return '/menu';
      },
    ),
    MenuRoutes.menu,
    MenuRoutes.levelSelector,
    GameRoutes.game,
    ShopRoutes.shop,
    ShopRoutes.realshop,
  ],
);
