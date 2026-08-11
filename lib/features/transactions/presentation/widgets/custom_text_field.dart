import 'package:flutter/material.dart';

/// حقل نص مخصص وقابل لإعادة الاستخدام (Custom Text Field)
///
/// يوفر تنسيقاً موحداً (ألوان، حواف مستديرة) لجميع حقول الإدخال في التطبيق،
/// مع دعم اختياري لنوع الكيبورد والحد الأقصى لعدد الأحرف.
class CustomTextField extends StatefulWidget {
  final String hint;                 // النص التلميحي (placeholder) داخل الحقل
  final TextInputType? keyboardType; // نوع الكيبورد (مثلاً أرقام)
  final int? maxLength;              // الحد الأقصى لعدد الأحرف المسموح بها
  final TextEditingController controller; // للتحكم بقيمة الحقل من الخارج


  const CustomTextField({
    super.key,
    required this.hint,
    this.keyboardType,
    this.maxLength,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 56,
      child: TextField(
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF0A5C2D)),
        cursorColor: Color(0xFF0A5C2D),
        controller: widget.controller,
        decoration: InputDecoration(
          counterText: "", // إخفاء عدّاد الأحرف الافتراضي أسفل الحقل
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Color(0xFF0A5C2D).withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(),
          // شكل الحدود عند التركيز (focus) على الحقل
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2ECC71), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          // شكل الحدود في الحالة العادية (غير مركّز عليها)
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2ECC71), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        // إلغاء تركيز الحقل عند الضغط خارج منطقته (إخفاء الكيبورد)
        onTapOutside: (pointerDownEvent) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}