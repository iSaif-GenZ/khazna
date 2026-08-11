import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/transactions/presentation/cubit/image_picker/image_picker_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/image_picker/image_picker_state.dart';

/// زر دائري متحرك لاختيار/عرض صورة المعاملة (Product Image Picker Button)
///
/// يعرض حالة مختلفة بحسب [ImagePickerState]:
/// - تحميل: مؤشر دوران
/// - لا توجد صورة: أيقونة كاميرا
/// - توجد صورة: عرض الصورة المقتصّة داخل دائرة
/// كما يحتوي على تأثير تصغير بسيط (scale) عند الضغط لإعطاء إحساس تفاعلي.
class CustomIconButton extends StatefulWidget {
  const CustomIconButton({super.key});

  @override
  State<StatefulWidget> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  // متغير محلي لتتبع حالة الضغط لإنتاج تأثير التصغير المتحرك
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // الاستماع إلى ImagePickerCubit لإعادة البناء عند تغيّر حالة اختيار الصورة
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        String? imagePath;
        if (state is ImagePickerSuccess) {
          imagePath = state.imagePath;
        }
        return AnimatedScale(
          // تصغير الزر قليلاً أثناء الضغط عليه (تأثير بصري)
          scale: _isPressed ? 0.93 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                _isPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _isPressed = false;
              });
            },
            // عند الضغط: استدعاء اختيار الصورة وقصّها عبر الـ Cubit
            onTap: () {
              context.read<ImagePickerCubit>().pickAndCrop();
            },
            child: Container(
              // حشوة أكبر عند عدم وجود صورة (لتكبير الأيقونة داخل الدائرة)
              padding: EdgeInsets.all(imagePath == null ? 32 : 4),
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Color(0xFF2ECC71)),
                shape: BoxShape.circle,
              ),
              // عرض مختلف بحسب حالة اختيار الصورة الحالية
              child: state is ImagePickerLoading
                  ? const SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        color: Color(0xFF2ECC71),
                      ),
                    )
                  : imagePath == null
                  ? const Icon(
                      Icons.add_a_photo,
                      size: 80,
                      color: Color(0xFF2ECC71),
                    )
                  // عرض الصورة المختارة مقصوصة ضمن شكل دائري
                  : ClipOval(
                      child: Image.file(
                        File(imagePath),
                        width: 136,
                        height: 136,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}