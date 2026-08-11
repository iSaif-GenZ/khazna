import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';
import 'package:khazna/features/transactions/presentation/cubit/image_picker/image_picker_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/image_picker/image_picker_state.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_state.dart';
import 'package:khazna/features/transactions/presentation/widgets/add_transaction_button.dart';
import 'package:khazna/features/transactions/presentation/widgets/custom_icon_button.dart';
import 'package:khazna/features/transactions/presentation/widgets/fields_container.dart';
import 'package:khazna/service_locator.dart';

/// شاشة إضافة معاملة جديدة (Add Transaction Screen)
///
/// تعرض فورم لإدخال بيانات معاملة جديدة (اسم منتج، مصدر، فئة، سعر، صورة)
/// وتقوم بحفظها عبر [TransactionCubit].
class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  // Controllers لكل حقل نصي في الفورم
  final TextEditingController _PNameController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    // تحرير الـ Controllers لتفادي تسريب الذاكرة (Memory Leak)
    _PNameController.dispose();
    _sourceController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  /// يبني كائن [Transaction] من قيم الحقول الحالية والصورة المختارة (إن وجدت)
  /// ثم يرسله إلى [TransactionCubit] للحفظ.
  void _saveTransaction(BuildContext context) {
    // قراءة حالة اختيار الصورة الحالية من ImagePickerCubit
    final imagePickerState = context.read<ImagePickerCubit>().state;

    // استخراج مسار الصورة فقط إذا كانت الحالة "نجاح"، وإلا null
    final String? imagePath = imagePickerState is ImagePickerSuccess
        ? imagePickerState.imagePath
        : null;

    final transaction = Transaction(
      productName: _PNameController.text,
      source: _sourceController.text,
      category: _categoryController.text,
      // تحويل النص إلى رقم، وإذا فشل التحويل (نص فارغ/غير صالح) نستخدم 0
      price: double.tryParse(_priceController.text) ?? 0,
      imageUrl: imagePath,
      date: DateTime.now(),
    );

    context.read<TransactionCubit>().addTransaction(transaction);
  }

  @override
  Widget build(BuildContext context) {
    // توفير الـ Cubits الخاصة بهذه الشاشة فقط (Scoped Providers)
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ImagePickerCubit>()),
        BlocProvider(create: (_) => sl<TransactionCubit>()),
      ],
      child: BlocConsumer<TransactionCubit, TransactionState>(
        // Listener: تنفيذ تأثيرات جانبية (side effects) بدون إعادة بناء الواجهة
        listener: (context, state) {
          if (state is TransactionLoaded) {
            // إغلاق الشاشة والعودة بعد نجاح الحفظ
            Navigator.pop(context);
          }
        },
        // Builder: بناء الواجهة بناءً على الحالة
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7FDF9),

            appBar: AppBar(
              iconTheme: const IconThemeData(color: Color(0xFF2ECC71)),
              backgroundColor: const Color(0xFFF7FDF9),
              scrolledUnderElevation: 0,
              title: const Text(
                "Add transaction",
                style: TextStyle(
                  color: Color(0xFF2ECC71),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            body: SingleChildScrollView(
              // يمنع الـ overflow عند ظهور الكيبورد فوق الحقول
              padding: const EdgeInsets.all(16),
              child: Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // زر اختيار/عرض صورة المنتج
                    const CustomIconButton(),
                    const SizedBox(height: 32),

                    // حاوية حقول الإدخال (اسم المنتج، المصدر، الفئة، السعر)
                    FieldsContainer(
                      PNameCtrl: _PNameController,
                      sourceCtrl: _sourceController,
                      categoryCtrl: _categoryController,
                      priceCtrl: _priceController,
                    ),
                    const SizedBox(height: 32),

                    // زر تأكيد إضافة المعاملة -> يستدعي _saveTransaction
                    AddTransactionButton(
                      onPressesd: () => _saveTransaction(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}