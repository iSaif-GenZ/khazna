import 'package:flutter/material.dart';

class NavBarIconButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;
  const NavBarIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isSelected
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      onPressed: onPressed,
     icon: Icon(
      icon, 
      color: isSelected ? Color(0xFF2ECC71) : Color.fromARGB(255, 39, 164, 91),
      size: 26,
    ));
  }
}
