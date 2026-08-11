class SettingsState {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String currency;

  const SettingsState({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.currency = "USD",
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? currency,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      currency: currency ?? this.currency,
    );
  }
}