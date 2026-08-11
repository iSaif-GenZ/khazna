import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_state.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction_summary/transaction_summary_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction_summary/transaction_summary_state.dart';
import 'package:khazna/service_locator.dart';

/// بطاقة ملخص المحفظة (Wallet Summary Card)
///
/// تحتوي على إجمالي الرصيد [TotalBalance] وصف الإيرادات/المصروفات
/// [ExpensesAndRevenues] داخل حاوية بتدرج لوني أخضر وظل خفيف.
class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (create) => sl<TransactionSummaryCubit>(),
      child: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoaded) {
            context.read<TransactionSummaryCubit>().calculateSummary(
              state.transactions,
            );
          }
        },
        child: BlocBuilder<TransactionSummaryCubit, TransactionSummaryState>(
          builder: (context, state) {
            final totalBalance = state is TransactionSummaryCalculated
                ? state.totalBalance
                : 0.0;
            final totalIncome = state is TransactionSummaryCalculated
                ? state.totalIncome
                : 0.0;
            final totalExpenses = state is TransactionSummaryCalculated
                ? state.totalExpenses.abs()
                : 0.0;

            if (state is TransactionSummaryCalculated) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // تدرج لوني (Gradient) من الأخضر الفاتح إلى الأخضر الغامق
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2ECC71),
                      Color.fromARGB(255, 39, 164, 91),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  // ظل خفيف تحت البطاقة لإعطاء إحساس بالعمق
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2ECC71).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalBalance(balance: totalBalance),
                    const SizedBox(height: 24),
                    ExpensesAndRevenues(
                      expenses: totalExpenses,
                      income: totalIncome,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

/// يعرض إجمالي الرصيد الحالي (حالياً قيمة ثابتة "$0.00")
class TotalBalance extends StatelessWidget {
  final double balance;
  const TotalBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان توضيحي صغير
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              style: TextStyle(
                color: Color(0xFFF7FDF9).withOpacity(0.9),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.0,
              ),

              "Total balance",
            ),
          ),
          SizedBox(height: 8),
          // القيمة الرقمية الرئيسية للرصيد
          Text(
            "\$${balance.toStringAsFixed(2)}",
            style: TextStyle(
              color: Color(0xFFF7FDF9),
              fontWeight: FontWeight.bold,
              fontSize: 32,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// صف يعرض بطاقتين جنباً إلى جنب: الإيرادات (Revenues) والمصروفات (Expenses)
class ExpensesAndRevenues extends StatelessWidget {
  final double income;
  final double expenses;
  const ExpensesAndRevenues({
    super.key,
    required this.expenses,
    required this.income,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        // بطاقة الإيرادات (لون أخضر + إشارة +)
        Expanded(
          child: StateTile(
            title: "revenues",
            value: income,
            state: "+",
            circleColor: Color(0xFF2ECC71),
            statisticsColor: Color(0xFF2ECC71),
          ),
        ),
        SizedBox(width: 12),
        // بطاقة المصروفات (لون أحمر + إشارة -)
        Expanded(
          child: StateTile(
            title: "expenses",
            value: expenses,
            state: "-",
            circleColor: Color(0xFFFF6B6B),
            statisticsColor: Color(0xFFFF6B6B),
          ),
        ),
      ],
    );
  }
}

/// بطاقة صغيرة (Tile) قابلة لإعادة الاستخدام تعرض عنوان وقيمة مع مؤشر لوني دائري
///
/// تُستخدم لعرض كل من الإيرادات والمصروفات في [ExpensesAndRevenues]
class StateTile extends StatelessWidget {
  final String title; // عنوان البطاقة (مثال: revenues / expenses)
  final double value; // القيمة الرقمية المعروضة
  final String state; // إشارة (+/-) تُضاف قبل القيمة
  final Color circleColor; // لون المؤشر الدائري الصغير
  final Color statisticsColor; // لون نص القيمة الرقمية

  const StateTile({
    super.key,
    required this.title,
    required this.value,
    required this.state,
    required this.circleColor,
    required this.statisticsColor,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Color(0xFFF7FDF9),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // مؤشر دائري صغير يوضح نوع البطاقة (إيراد/مصروف) بلون مختلف
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان البطاقة
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                  height: 1.2,
                ),
              ),
              // القيمة مع الإشارة (مثال: +$0.0 أو -$0.0)
              Text(
                "$state\$${value.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: statisticsColor,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
