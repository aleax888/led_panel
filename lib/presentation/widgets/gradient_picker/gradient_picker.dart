import 'package:led_panel/presentation/widgets/gradient_editor/gradient_editor.dart';

export 'package:led_panel/presentation/widgets/gradient_editor/gradient_stop.dart';

@Deprecated('Use GradientEditor instead.')
class GradientPicker extends GradientEditor {
  const GradientPicker({super.key, required super.stops, super.onChanged});
}
