import 'package:led_panel/data/enums/background_type_enum.dart';

/// Abstract class representing the configuration for a background.
abstract class BackgroundConfigModel {
  BackgroundTypeEnum get type;
  const BackgroundConfigModel();

  BackgroundConfigModel copyWith();
  Map<String, dynamic> toJson();
}
