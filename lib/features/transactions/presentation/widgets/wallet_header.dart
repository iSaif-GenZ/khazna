import 'package:flutter/material.dart';
import 'package:khazna/features/transactions/presentation/widgets/custom_appbar.dart';
import 'package:khazna/features/transactions/presentation/widgets/custom_card.dart';
import 'dart:ui';

/// رأس الشاشة الرئيسية (Wallet Header)
///
/// SliverAppBar يجمع بين شريط التطبيق [CustomAppbar] وبطاقة ملخص المحفظة
/// [CustomCard]، مع سلوك floating/snap يجعله يظهر ويختفي بسلاسة أثناء التمرير.
class WalletHeader extends StatelessWidget {
  const WalletHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      floating: true, // يظهر الشريط فور التمرير للأعلى قليلاً
      snap: true, // يكتمل ظهوره/اختفاؤه دفعة واحدة بدلاً من التدرج
      pinned: false, // لا يبقى ثابتاً أعلى الشاشة عند التمرير
      expandedHeight:
          364, // الارتفاع الكامل عند التوسّع (يشمل الشريط + البطاقة)
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      primary: false,
      toolbarHeight: 0,
      flexibleSpace: FlexibleSpaceBar(
        // بطاقة ملخص المحفظة تظهر ضمن المساحة المرنة أسفل الشريط
        background: ClipRRect(borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              color: Colors.white.withValues(alpha: 0.16),
              child: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomAppbar(),
                      SizedBox(height: 12),
                      CustomCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
