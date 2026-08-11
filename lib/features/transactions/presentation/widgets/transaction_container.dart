import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_state.dart';
import 'package:khazna/features/transactions/presentation/widgets/swipe_to_delete_transaction.dart';
import 'package:khazna/features/transactions/presentation/widgets/treatment.dart';

/// Widget مسؤول عن عرض قائمة المعاملات (Transactions) المخزنة في قاعدة بيانات Isar.
class TransactionContainer extends StatelessWidget {
  const TransactionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // تحديد لون خلفية حاوية المعاملات
        color: const Color.fromARGB(0, 245, 247, 250),
      ),
      child: ClipRRect(
        // الاستماع لحالة TransactionCubit وبناء الواجهة المناسبة لكل حالة
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            // حالة التحميل: عرض مؤشر دوران
            if (state is TransactionLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
              );
            }
            // حالة نجاح تحميل البيانات
            if (state is TransactionLoaded) {
              // لا توجد معاملات بعد -> عرض رسالة توضيحية
              if (state.transactions.isEmpty) {
                return const Center(
                  child: Text(
                    "لا توجد معاملات حالياً",
                    style: TextStyle(color: Color(0xFF2ECC71), fontSize: 16),
                  ),
                );
              }

              // عرض قائمة المعاملات
              // shrinkWrap + NeverScrollableScrollPhysics لأن القائمة
              // موضوعة داخل CustomScrollView (Sliver) خارجي يتولى التمرير
              return ListView.builder(
                padding: EdgeInsets.only(top: 8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.transactions.length,
                itemBuilder: (context, i) {
                  final reversedIndex = state.transactions.length - 1 - i;
                  final transaction = state.transactions[reversedIndex];

                  return SwipeToDeleteTransaction(
                    child: Treatment(transaction: transaction),
                    onDismissed: () {
                      context.read<TransactionCubit>().deleteTransaction(transaction.id!);
                    },
                  );
                },
              );
            }
            // حالة حدوث خطأ: عرض رسالة الخطأ باللون الأحمر
            if (state is TransactionError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            // أي حالة أخرى غير متوقعة: لا تُعرض أي واجهة
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
