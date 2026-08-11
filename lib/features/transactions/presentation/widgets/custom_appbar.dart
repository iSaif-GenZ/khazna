import 'package:flutter/material.dart';

/// شريط التطبيق المخصص (Custom App Bar)
///
/// يعرض شعار التطبيق "KHAZNA" مع أيقونة محفظة داخل حاوية مستديرة الحواف.
/// يُستخدم عادةً كـ title داخل SliverAppBar (راجع WalletHeader).
class CustomAppbar extends StatelessWidget {
  const  CustomAppbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // هامش علوي كبير (56) لإبعاد الشريط عن أعلى الشاشة (مساحة الـ status bar)
      margin: const EdgeInsets.only(left: 8, right: 12, top: 24),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFE6F9EE), // خلفية خضراء فاتحة جداً
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            // شريط عمودي صغير كعنصر تصميمي (accent) بجانب الشعار
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2ECC71),
                borderRadius: BorderRadius.circular(24),
                // borderRadius: BorderRadius.only(
                //   topRight: Radius.circular(0),
                //   bottomRight: Radius.circular(0),
                //   topLeft: Radius.circular(24),
                //   bottomLeft: Radius.circular(24)
                // )
              ),
              // margin: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.only(right: 8),
              height: 40,
              width: 4,
            ),
            // اسم التطبيق
            Text(
              "KHAZNA",
              style: TextStyle(
                letterSpacing: 2,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                color: Color(0xFF2ECC71),
                fontSize: 22,
              ),
            ),
            SizedBox(width: 3),
            // أيقونة محفظة مكملة للشعار
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(Icons.wallet, size: 32, color: Color(0xFF2ECC71)),
            ),
          ],
        ),
      ),
    );
  }
}