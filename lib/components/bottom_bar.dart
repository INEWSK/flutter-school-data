import 'package:flutter/material.dart';

class BottomTapBar extends StatelessWidget {
  const BottomTapBar({
    Key? key,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  final Function(int)? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
      currentIndex: index,
      onTap: onTap,
    );
  }
}
