import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:khazna/features/statistics/domain/entities/trend_point.dart';

class TrendChartCard extends StatelessWidget {
  final List<TrendPoint> trend;
  const TrendChartCard({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    final maxY = trend.fold<double>(0, (max, t) {
      final localMax = t.income > t.expense ? t.income : t.expense;
      return localMax > max ? localMax : max;
    });
    final safeMaxY = maxY == 0 ? 10.0 : maxY * 1.2;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Last 7 days",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0A5C2D)),
              ),
              const Spacer(),
              const _LegendDot(color: Color(0xFF2ECC71), label: "Income"),
              const SizedBox(width: 12),
              const _LegendDot(color: Color(0xFFFF6B6B), label: "Expense"),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                maxY: safeMaxY,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= trend.length) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            trend[i].label,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barTouchData: BarTouchData(enabled: true),
                barGroups: List.generate(trend.length, (i) {
                  final t = trend[i];
                  return BarChartGroupData(
                    x: i,
                    barsSpace: 4,
                    barRods: [
                      BarChartRodData(
                        toY: t.income,
                        color: const Color(0xFF2ECC71),
                        width: 7,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      BarChartRodData(
                        toY: t.expense,
                        color: const Color(0xFFFF6B6B),
                        width: 7,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500)),
      ],
    );
  }
}