import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:khazna/features/transactions/presentation/widgets/nav_bar_icon_button.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.16)),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavBarIconButton(
                icon: Icons.home,
                onPressed: () => onTap(0),
                isSelected: currentIndex == 0,
              ),
              NavBarIconButton(
                icon: Icons.bar_chart,
                onPressed: () => onTap(1),
                isSelected: currentIndex == 1,
              ),
              NavBarIconButton(
                icon: Icons.settings,
                onPressed: () => onTap(2),
                isSelected: currentIndex == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}