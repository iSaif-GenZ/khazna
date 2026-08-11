import 'package:flutter/material.dart';

class SettingsNavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final Color? titleColor;
  final VoidCallback? onTap;

  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3)),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (titleColor ?? const Color(0xFF2ECC71)).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: titleColor ?? const Color(0xFF2ECC71), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: titleColor ?? const Color(0xFF0A5C2D)),
                ),
              ),
              if (trailingText != null)
                Text(trailingText!, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)))
              else if (onTap != null)
                const Icon(Icons.chevron_right_rounded, color: Color(0xFF6B7280)),
            ],
          ),
        ),
      ),
    );
  }
}