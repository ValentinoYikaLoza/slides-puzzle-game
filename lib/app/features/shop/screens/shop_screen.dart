import 'package:flutter/material.dart';
import 'package:gambling_game/app/features/shared/widgets/custom_appbar.dart';
import 'package:gambling_game/app/features/shop/widgets/custom_item.dart';
import 'package:gambling_game/app/features/shop/widgets/custom_item_card.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});
  // Example list of shop items
  final List<CustomItem> shopItems = [
    CustomItem(
      name: 'Puzzle Theme 1',
      price: 100,
      icon: Icons.grid_on,
    ),
    CustomItem(
      name: 'Puzzle Theme 2',
      price: 200,
      icon: Icons.grid_on,
    ),
    CustomItem(
      name: 'Hint Power-Up',
      price: 50,
      icon: Icons.lightbulb_outline,
    ),
    CustomItem(
      name: 'Shuffle Power-Up',
      price: 75,
      icon: Icons.shuffle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(tittle: 'Shop'),
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
            return CustomItemCard(
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
