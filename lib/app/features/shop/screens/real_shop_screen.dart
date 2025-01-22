import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';

class PremiumShopScreen extends StatelessWidget {
  // Example list of premium items
  final List<PremiumItem> premiumItems = [
    PremiumItem(
      name: 'Exclusive Puzzle Theme',
      price: 4.99,
      icon: Icons.grid_on,
    ),
    PremiumItem(
      name: '500 Coins',
      price: 2.99,
      icon: Icons.monetization_on,
    ),
    PremiumItem(
      name: 'Unlimited Hints',
      price: 9.99,
      icon: Icons.lightbulb_outline,
    ),
    PremiumItem(
      name: 'Remove Ads',
      price: 3.99,
      icon: Icons.remove_circle_outline,
    ),
  ];

  PremiumShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        surfaceTintColor: Colors.blue.shade50,
        title: Center(
          child: Text(
            'Premium Shop',
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
          onPressed: () {
            AppRouter.go(MenuRoutes.menu.path);
          },
        ),
      ),
      body: Container(
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: premiumItems.length,
          itemBuilder: (context, index) {
            final item = premiumItems[index];
            return PremiumItemCard(
              item: item,
              onPressed: () {
                // Simulate purchase logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Purchased ${item.name} for \$${item.price.toStringAsFixed(2)}!'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class PremiumItem {
  final String name;
  final double price;
  final IconData icon;

  PremiumItem({
    required this.name,
    required this.price,
    required this.icon,
  });
}

class PremiumItemCard extends StatelessWidget {
  final PremiumItem item;
  final VoidCallback onPressed;

  const PremiumItemCard({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(item.icon, color: Colors.blue.shade800, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Buy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
