import 'dart:ui';

import 'package:flutter/material.dart';

/// زر إضافة المعاملة (Add Transaction Button)
///
/// زر بسيط يُستخدم في شاشة إضافة معاملة، يستقبل دالة callback
/// تُنفَّذ عند الضغط عليه.
class AddTransactionButton extends StatefulWidget {
  // الدالة التي تُستدعى عند الضغط على الزر (تُمرَّر من الشاشة الأم)
  final VoidCallback onPressesd;
  const AddTransactionButton({super.key, required this.onPressesd});

  @override
  State<AddTransactionButton> createState() => _AddTransactionButtonState();
}

class _AddTransactionButtonState extends State<AddTransactionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71), // لون خلفية الزر (أخضر)
        foregroundColor: const Color(0xFFF7FDF9), // لون المحتوى (نص/أيقونة)
        textStyle: const TextStyle(color: Color(0xFFF7FDF9)),
        minimumSize: const Size(200, 54), // أبعاد دنيا للزر
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: widget.onPressesd, // استدعاء الـ callback الممرر من الأب
      child: const Text(
        "Add",
        style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    );
  }
}