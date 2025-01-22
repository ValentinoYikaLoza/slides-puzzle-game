import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});
  // Example list of shop items
  final List<ShopItem> shopItems = [
    ShopItem(
      name: 'Puzzle Theme 1',
      price: 100,
      icon: Icons.grid_on,
    ),
    ShopItem(
      name: 'Puzzle Theme 2',
      price: 200,
      icon: Icons.grid_on,
    ),
    ShopItem(
      name: 'Hint Power-Up',
      price: 50,
      icon: Icons.lightbulb_outline,
    ),
    ShopItem(
      name: 'Shuffle Power-Up',
      price: 75,
      icon: Icons.shuffle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        surfaceTintColor: Colors.blue.shade50,
        title: Center(
          child: Text(
            'Shop',
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
          itemCount: shopItems.length,
          itemBuilder: (context, index) {
            final item = shopItems[index];
            return ShopItemCard(
              item: item,
              onPressed: () {
                // Handle purchase logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Purchased ${item.name} for ${item.price} coins!'),
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

class ShopItem {
  final String name;
  final int price;
  final IconData icon;

  ShopItem({
    required this.name,
    required this.price,
    required this.icon,
  });
}

class ShopItemCard extends StatelessWidget {
  final ShopItem item;
  final VoidCallback onPressed;

  const ShopItemCard({
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
                    '${item.price} coins',
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
