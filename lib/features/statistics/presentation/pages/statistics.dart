import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/statistics/domain/cubit/statistics_state.dart';
import 'package:khazna/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:khazna/features/statistics/presentation/widgets/category_breakdown_card.dart';
import 'package:khazna/features/statistics/presentation/widgets/statistics_header.dart';
import 'package:khazna/features/statistics/presentation/widgets/statistics_summary_row.dart';
import 'package:khazna/features/statistics/presentation/widgets/trend_chart_card.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_state.dart';
import 'package:khazna/service_locator.dart';

class Statistics extends StatelessWidget {
  final ScrollController scrollController;
  const Statistics({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<StatisticsCubit>();
        // نحسب الإحصائيات فوراً لو الـ TransactionCubit عنده بيانات محمّلة أصلاً
        final transactionState = context.read<TransactionCubit>().state;
        if (transactionState is TransactionLoaded) {
          cubit.calculateStatistics(transactionState.transactions);
        }
        return cubit;
      },
      child: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoaded) {
            context.read<StatisticsCubit>().calculateStatistics(state.transactions);
          }
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            const SliverToBoxAdapter(child: StatisticsHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 140),
              sliver: SliverToBoxAdapter(
                child: BlocBuilder<StatisticsCubit, StatisticsState>(
                  builder: (context, state) {
                    if (state is StatisticsLoaded) {
                      return Column(
                        children: [
                          StatisticsSummaryRow(
                            income: state.totalIncome,
                            expenses: state.totalExpenses,
                            count: state.transactionCount,
                          ),
                          const SizedBox(height: 16),
                          TrendChartCard(trend: state.trend),
                          const SizedBox(height: 16),
                          CategoryBreakdownCard(categories: state.categoryBreakdown),
                        ],
                      );
                    }
                    if (state is StatisticsEmpty) {
                      return const _EmptyStatistics();
                    }
                    return const SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator(color: Color(0xFF2ECC71))),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyStatistics extends StatelessWidget {
  const _EmptyStatistics();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: [
          Icon(Icons.insert_chart_outlined, size: 64, color: const Color(0xFF2ECC71).withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text(
            "لا توجد بيانات كافية بعد",
            style: TextStyle(color: Color(0xFF2ECC71), fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}