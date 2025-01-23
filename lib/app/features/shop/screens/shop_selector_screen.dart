import 'package:flutter/material.dart';
import 'package:gambling_game/app/features/shared/widgets/custom_appbar.dart';
import 'package:gambling_game/app/features/shop/screens/real_shop_screen.dart';
import 'package:gambling_game/app/features/shop/screens/shop_screen.dart';

class ShopSelectorScreen extends StatefulWidget {
  const ShopSelectorScreen({super.key});

  @override
  State<ShopSelectorScreen> createState() => _ShopSelectorScreenState();
}

class _ShopSelectorScreenState extends State<ShopSelectorScreen> {
  int _selectedIndex = 0;

  // Screens for the bottom navigation bar
  final List<Widget> _screens = [
    ShopScreen(),
    PremiumShopScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue.shade800,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.grey.shade600,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Premium shop',
          ),
        ],
      ),
    );
  }
}
