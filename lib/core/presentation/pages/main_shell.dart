import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/settings/presentation/pages/settings.dart';
import 'package:khazna/features/statistics/presentation/pages/statistics.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:khazna/features/transactions/presentation/pages/home.dart';
import 'package:khazna/features/transactions/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:khazna/features/transactions/presentation/widgets/hide_on_scroll.dart';
import 'package:khazna/service_locator.dart';

/// الحاوية الرئيسية للتطبيق (Root Shell)
///
/// تدير التبديل الفعلي بين Home / Statistics / Settings عبر IndexedStack
/// (يحافظ على حالة كل شاشة)، وتوفّر TransactionCubit واحد مشترك
/// بين الشاشات كلها حتى تبقى البيانات متزامنة (إضافة معاملة بالهوم
/// تنعكس فوراً بالإحصائيات).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final ScrollController _homeScrollController = ScrollController();
  final ScrollController _statisticsScrollController = ScrollController();
  final ScrollController _settingsScrollController = ScrollController();

  late final List<ScrollController> _controllers = [
    _homeScrollController,
    _statisticsScrollController,
    _settingsScrollController,
  ];

  @override
  void dispose() {
    _homeScrollController.dispose();
    _statisticsScrollController.dispose();
    _settingsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TransactionCubit>()..getTransactions(),
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: [
                Home(scrollController: _homeScrollController),
                Statistics(scrollController: _statisticsScrollController),
                Settings(scrollController: _settingsScrollController),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: HideOnScroll(
                controller: _controllers[_selectedIndex],
                child: CustomBottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}