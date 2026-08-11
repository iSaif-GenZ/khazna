import 'package:flutter/material.dart';

class StatisticsHeader extends StatelessWidget {
  const StatisticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8, right: 12, top: 24, bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFE6F9EE),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71),
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: const EdgeInsets.only(right: 8),
                height: 40,
                width: 4,
              ),
              const Text(
                "STATISTICS",
                style: TextStyle(
                  letterSpacing: 2,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2ECC71),
                  fontSize: 22,
                ),
              ),
              const SizedBox(width: 3),
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.insert_chart_rounded, size: 30, color: Color(0xFF2ECC71)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}