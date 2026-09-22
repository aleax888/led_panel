import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';

abstract class LedPanelListRepository {
  Future<List<LedPanelConfigModel>> getAll();
  Future<void> save(LedPanelConfigModel config);
  Future<void> delete(String id);
  Future<void> clear();
}
