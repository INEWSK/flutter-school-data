import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;
  final Color activeColor, inActiveColor;

  const DotIndicator(
      {Key? key,
      this.isActive = false,
      this.activeColor = Colors.blueAccent,
      this.inActiveColor = const Color(0xFF868686)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 375),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 6.0,
      width: 6.0,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
