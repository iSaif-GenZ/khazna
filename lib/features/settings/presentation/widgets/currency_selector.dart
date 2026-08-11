import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;
  static const List<String> currencies = ["USD", "EUR", "IQD"];

  const CurrencySelector({super.key, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Currency", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0A5C2D))),
          const SizedBox(height: 10),
          Row(
            children: currencies.map((c) {
              final isSelected = c == selected;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onSelected(c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2ECC71) : const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      c,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}