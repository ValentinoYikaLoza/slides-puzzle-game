import 'package:flutter/material.dart';
import 'package:gambling_game/app/features/shared/widgets/custom_appbar.dart';
import 'package:gambling_game/app/features/shop/widgets/custom_item.dart';
import 'package:gambling_game/app/features/shop/widgets/custom_item_card.dart';

class PremiumShopScreen extends StatelessWidget {
  // Example list of premium items
  final List<CustomItem> premiumItems = [
    CustomItem(
      name: 'Exclusive Puzzle Theme',
      price: 4.99,
      icon: Icons.grid_on,
    ),
    CustomItem(
      name: '500 Coins',
      price: 2.99,
      icon: Icons.monetization_on,
    ),
    CustomItem(
      name: 'Unlimited Hints',
      price: 9.99,
      icon: Icons.lightbulb_outline,
    ),
    CustomItem(
      name: 'Remove Ads',
      price: 3.99,
      icon: Icons.remove_circle_outline,
    ),
  ];

  PremiumShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(tittle: 'Premium shop'),
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
            return CustomItemCard(
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