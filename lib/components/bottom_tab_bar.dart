import 'package:flutter/material.dart';

import '../generated/l10n.dart';

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
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: S.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          label: S.of(context).search,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: S.of(context).setting,
        ),
      ],
      currentIndex: index,
      onTap: onTap,
    );
  }
}
