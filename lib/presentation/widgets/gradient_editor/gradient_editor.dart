import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_dialog.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/gradient_editor_metrics.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/gradient_stop.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/gradient_stop_field.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/stop_position_dialog.dart';
import 'package:led_panel/presentation/widgets/saved_config_item/delete_validation_dialog.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Class that builds the gradient editor widget, which allows users to edit a gradient by adding, removing, and moving gradient stops.
class GradientEditor extends StatefulWidget {
  final List<GradientStop> stops;
  final ValueChanged<List<GradientStop>>? onChanged;

  const GradientEditor({super.key, required this.stops, this.onChanged})
    : assert(stops.length >= 2);

  @override
  State<GradientEditor> createState() => _GradientEditorState();
}

class _GradientEditorState extends State<GradientEditor> {
  final GlobalKey _trackKey = GlobalKey();
  late final List<GradientStop> _stops = List.of(widget.stops);

  List<GradientStop> get _sorted =>
      List.of(_stops)..sort((a, b) => a.position.compareTo(b.position));

  @override
  Widget build(BuildContext context) {
    final List<GradientStop> sorted = _sorted;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Expanded(
          child: SizedBox(
            height: GradientEditorMetrics.height,
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                key: _trackKey,
                children: [
                  // Gradient Track ----------------------------------------------
                  Positioned(
                    top: GradientEditorMetrics.trackTop,
                    left: 0,
                    right: 0,
                    height: GradientEditorMetrics.trackHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [for (final s in sorted) s.color],
                          stops: [for (final s in sorted) s.position / 100],
                        ),
                        border: Border.all(
                          color: context.colors.outline,
                          width: AppSizes.borderWidthThick,
                        ),
                        borderRadius: AppRadius.borderRadiusLg,
                      ),
                    ),
                  ),

                  // Gradient Stops ----------------------------------------------
                  for (final (index, stop) in _stops.indexed)
                    GradientStopField(
                      stop: stop,
                      width: constraints.maxWidth,
                      onTap: () => _editColor(index),
                      onLongPress: () => _deleteStop(index),
                      onDrag: (globalX) => _move(index, globalX),
                    ),
                ],
              ),
            ),
          ),
        ),

        // Add Stop Button ----------------------------------------------
        Padding(
          padding: const EdgeInsets.only(top: GradientEditorMetrics.trackTop),
          child: IconButton(
            tooltip: 'Add stop',
            onPressed: _addStop,
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
              fixedSize: const Size.square(GradientEditorMetrics.trackHeight),
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }

  /// Show a dialog to add a new stop and add it to the list of stops if the user confirms.
  Future<void> _addStop() async {
    final int? position = await showDialog<int>(
      context: context,
      builder: (_) => const StopPositionDialog(),
    );
    if (position == null || !mounted) return;

    setState(() {
      _stops.add(GradientStop(position: position, color: _colorAt(position)));
    });
    _notifyChanged();
  }

  /// Show a dialog to confirm the deletion of the stop at [index] and remove it from the list of stops if the user confirms.
  Future<void> _deleteStop(int index) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteValidationDialog(),
    );

    if (mounted && confirmDelete == true && _stops.length > 2) {
      setState(() => _stops.removeAt(index));
      _notifyChanged();
    }
  }

  /// Show a dialog to edit the color of the stop at [index] and update its color if the user selects one.
  Future<void> _editColor(int index) async {
    final Color? color = await showDialog<Color>(
      context: context,
      builder: (_) => ColorPickerDialog(initialColor: _stops[index].color),
    );
    if (color == null || !mounted) return;

    setState(() => _stops[index] = _stops[index].copyWith(color: color));
    _notifyChanged();
  }

  /// Move the stop at [index] to the position corresponding to [globalX] and update the list of stops.
  void _move(int index, double globalX) {
    final RenderBox track =
        _trackKey.currentContext!.findRenderObject() as RenderBox;
    final double localX = track.globalToLocal(Offset(globalX, 0)).dx;
    final int position = (localX / track.size.width * 100).round().clamp(
      0,
      100,
    );
    if (position == _stops[index].position) return;

    setState(() => _stops[index] = _stops[index].copyWith(position: position));
    _notifyChanged();
  }

  /// Returns the color of the gradient at the specified position.
  Color _colorAt(int position) {
    final List<GradientStop> sorted = _sorted;
    final int end = sorted.indexWhere((s) => s.position >= position);
    if (end == -1) return sorted.last.color;
    if (end == 0) return sorted.first.color;

    final GradientStop a = sorted[end - 1], b = sorted[end];
    final double t = (position - a.position) / (b.position - a.position);
    return Color.lerp(a.color, b.color, t)!;
  }

  /// Notifies the listeners that the list of stops has changed.
  void _notifyChanged() => widget.onChanged?.call(List.unmodifiable(_sorted));
}
