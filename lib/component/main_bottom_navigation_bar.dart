import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainBottomNavigationBar extends ConsumerStatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  ConsumerState createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState
    extends ConsumerState<MainBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    final currentPath = GoRouter.of(context).state.path;
    _setInitialIndex(currentPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
      ],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  void _setInitialIndex(String? currentPath) {
    switch (currentPath) {
      case '/home':
        _selectedIndex = 0;
        break;
      default:
        _selectedIndex = 0;
    }
  }
}
