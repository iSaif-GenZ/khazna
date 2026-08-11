import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/settings/presentation/cubit/settings_state.dart';

/// حالياً القيم محفوظة بالذاكرة فقط (تنمسح عند إغلاق التطبيق)
/// TODO: اربطها بـ shared_preferences أو Isar للحفظ الدائم
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleNotifications(bool value) => emit(state.copyWith(notificationsEnabled: value));
  void toggleDarkMode(bool value) => emit(state.copyWith(darkModeEnabled: value));
  void setCurrency(String value) => emit(state.copyWith(currency: value));
}