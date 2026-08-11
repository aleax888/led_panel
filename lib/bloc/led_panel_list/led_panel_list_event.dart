part of 'led_panel_list_bloc.dart';

@immutable
sealed class LedPanelListEvent {}

class LedPanelListOpened extends LedPanelListEvent {}

class LedPanelListConfigSaved extends LedPanelListEvent {
  final LedPanelConfigModel config;
  LedPanelListConfigSaved(this.config);
}

class LedPanelListConfigDeleted extends LedPanelListEvent {
  final String id;
  LedPanelListConfigDeleted(this.id);
}

class LedPanelListFavorite extends LedPanelListEvent {
  final LedPanelConfigModel config;
  LedPanelListFavorite(this.config);
}
