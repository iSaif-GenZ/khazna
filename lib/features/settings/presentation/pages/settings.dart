import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:khazna/features/settings/presentation/cubit/settings_state.dart';
import 'package:khazna/features/settings/presentation/widgets/currency_selector.dart';
import 'package:khazna/features/settings/presentation/widgets/settings_header.dart';
import 'package:khazna/features/settings/presentation/widgets/settings_nav_tile.dart';
import 'package:khazna/features/settings/presentation/widgets/settings_section_title.dart';
import 'package:khazna/features/settings/presentation/widgets/settings_switch_tile.dart';
import 'package:khazna/service_locator.dart';

class Settings extends StatelessWidget {
  final ScrollController scrollController;
  const Settings({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsCubit>(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              const SliverToBoxAdapter(child: SettingsHeader()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 140),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SettingsSectionTitle(title: "Preferences"),
                    SettingsSwitchTile(
                      icon: Icons.notifications_none_rounded,
                      title: "Notifications",
                      subtitle: "Reminders and alerts",
                      value: state.notificationsEnabled,
                      onChanged: cubit.toggleNotifications,
                    ),
                    const SizedBox(height: 10),
                    SettingsSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: "Dark mode",
                      subtitle: "Coming soon",
                      value: state.darkModeEnabled,
                      onChanged: cubit.toggleDarkMode,
                    ),
                    const SizedBox(height: 10),
                    CurrencySelector(selected: state.currency, onSelected: cubit.setCurrency),
                    const SizedBox(height: 24),
                    const SettingsSectionTitle(title: "Data"),
                    SettingsNavTile(
                      icon: Icons.ios_share_rounded,
                      title: "Export data",
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Coming soon")),
                        );
                        // TODO: نادِ هنا ExportTransactionsUseCase لو ضفته لاحقاً
                      },
                    ),
                    const SizedBox(height: 10),
                    SettingsNavTile(
                      icon: Icons.delete_outline_rounded,
                      title: "Clear all data",
                      titleColor: const Color(0xFFFF6B6B),
                      onTap: () => _confirmClearData(context),
                    ),
                    const SizedBox(height: 24),
                    const SettingsSectionTitle(title: "About"),
                    const SettingsNavTile(
                      icon: Icons.info_outline_rounded,
                      title: "App version",
                      trailingText: "1.0.0",
                    ),
                    const SizedBox(height: 10),
                    SettingsNavTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy policy",
                      onTap: () {},
                    ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmClearData(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Clear all data?"),
        content: const Text("This will permanently delete all your transactions."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Color(0xFF6B7280))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // TODO: احذف كل المعاملات هنا (عبر DeleteTransactionUseCase بلوب،
              // أو أضف DeleteAllTransactionsUseCase بنفس نمط باقي الـ usecases)
            },
            child: const Text("Delete", style: TextStyle(color: Color(0xFFFF6B6B), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}