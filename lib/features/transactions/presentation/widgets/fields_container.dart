import 'package:flutter/material.dart';
import 'package:khazna/features/transactions/presentation/widgets/custom_text_field.dart';

/// حاوية تجمع كل حقول إدخال بيانات المعاملة (Fields Container)
///
/// تعرض أربعة حقول: اسم المنتج، المصدر، الفئة، والسعر، وتُمرَّر لها
/// الـ Controllers من الشاشة الأم للتحكم بالقيم وقراءتها لاحقاً.
class FieldsContainer extends StatefulWidget {
  final TextEditingController PNameCtrl;    // متحكم حقل اسم المنتج
  final TextEditingController sourceCtrl;   // متحكم حقل المصدر
  final TextEditingController categoryCtrl; // متحكم حقل الفئة
  final TextEditingController priceCtrl;    // متحكم حقل السعر

  const FieldsContainer({
    super.key,
    required this.PNameCtrl,
    required this.sourceCtrl,
    required this.categoryCtrl,
    required this.priceCtrl,
  });
  @override
  State<FieldsContainer> createState() => _FieldsContainerState();
}

class _FieldsContainerState extends State<FieldsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        children: [
          // حقل اسم المنتج
          CustomTextField(hint: "Product Name", controller: widget.PNameCtrl),
          const SizedBox(height: 16),
          // حقل مصدر المعاملة
          CustomTextField(hint: "Source", controller: widget.sourceCtrl),
          const SizedBox(height: 16),
          // حقل الفئة (بحد أقصى 6 أحرف)
          CustomTextField(
            hint: "Category",
            maxLength: 6, 
            controller: widget.categoryCtrl,
          ),
          const SizedBox(height: 16),
          // حقل السعر (كيبورد رقمي)
          CustomTextField(
            hint: "Price",
            keyboardType: TextInputType.number,
            controller: widget.priceCtrl,
          ),
        ],
      ),
    );
  }
}