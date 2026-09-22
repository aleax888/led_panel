import 'dart:convert';

import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/data/repositories/led_panel_list/led_panel_list_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsLedPanelListRepository implements LedPanelListRepository {
  static const _key = 'led_panel_list';

  @override
  Future<List<LedPanelConfigModel>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list
        .map((e) => LedPanelConfigModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> save(LedPanelConfigModel config) async {
    final items = await getAll();
    items.removeWhere((e) => e.id == config.id); // por si es una edición
    items.add(config);
    await _persist(items);
  }

  @override
  Future<void> delete(String id) async {
    final items = await getAll();
    items.removeWhere((e) => e.id == id);
    await _persist(items);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  Future<void> _persist(List<LedPanelConfigModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString(_key, raw);
  }
}
