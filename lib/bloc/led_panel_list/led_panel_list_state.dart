part of 'led_panel_list_bloc.dart';

@immutable
final class LedPanelListState {
  // Data
  final List<LedPanelConfigModel> configList;
  // States
  final bool isLoading;

  const LedPanelListState({this.configList = const [], this.isLoading = false});

  LedPanelListState copyWith({
    List<LedPanelConfigModel>? configList,
    bool? isLoading,
  }) {
    return LedPanelListState(
      configList: configList ?? this.configList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
