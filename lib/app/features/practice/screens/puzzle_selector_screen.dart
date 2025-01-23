import 'package:flutter/material.dart';
import 'package:gambling_game/app/config/router/app_router.dart';
import 'package:gambling_game/app/features/menu/routes/menu_routes.dart';
import 'package:gambling_game/app/features/practice/screens/image_puzzle_screen.dart';
import 'package:gambling_game/app/features/practice/screens/number_puzzle_screen.dart';
import 'package:gambling_game/app/features/shared/widgets/custom_appbar.dart';

class PuzzleSelectorScreen extends StatefulWidget {
  const PuzzleSelectorScreen({super.key});

  @override
  PuzzleSelectorScreenState createState() => PuzzleSelectorScreenState();
}

class PuzzleSelectorScreenState extends State<PuzzleSelectorScreen> {
  int _selectedIndex = 0;

  // Screens for the bottom navigation bar
  final List<Widget> _screens = [
    const ImagePuzzleScreen(),
    const NumberPuzzleScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onPressed: () {
          print('back');
          AppRouter.go(MenuRoutes.modeSelector.path);
        },
      ),
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
            icon: Icon(Icons.image),
            label: 'Image puzzle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.numbers),
            label: 'Number puzzle',
          ),
        ],
      ),
    );
  }
}
