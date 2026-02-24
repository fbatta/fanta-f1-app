import 'package:fanta_f1/route/route_names.dart';
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
  final Map<String, int> _pages = {
    RouteNames.home.path: 0,
    RouteNames.calendar.path: 1,
  };

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
    context.goNamed(
      RouteNames.fromPath(
        _pages.entries
            .firstWhere(
              (page) => page.value == value,
              orElse: () => MapEntry('/notFound', 99),
            )
            .key,
      ).name,
    );
  }

  void _setInitialIndex(String? currentPath) {
    final initialIndex = _pages.entries
        .firstWhere(
          (page) => page.key == currentPath,
          orElse: () => MapEntry('/home', 0),
        )
        .value;
    setState(() {
      _selectedIndex = initialIndex;
    });
  }
}
