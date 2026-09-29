import 'package:led_panel/data/enums/background_type_enum.dart';

abstract class BackgroundConfigModel {
  BackgroundTypeEnum get type;
  const BackgroundConfigModel();

  BackgroundConfigModel copyWith();
  Map<String, dynamic> toJson();
}
