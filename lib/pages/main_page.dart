import 'package:flutter/material.dart';

import '../components/bottom_tab_bar.dart';
import '../components/double_back_exit_app.dart';
import '../generated/l10n.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController();
  int _currentIndex = 0;

  final _screens = [
    const HomePage(),
    const SearchPage(),
    const SettingPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackExitApp(
      message: S.of(context).backToExit,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          bottomNavigationBar: BottomTapBar(
            onTap: _onPageChange,
            index: _currentIndex,
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChange,
            children: _screens,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
