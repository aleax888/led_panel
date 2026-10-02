import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/gradient_editor_metrics.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/gradient_stop.dart';
import 'package:led_panel/theme/constants/app_durations.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Class that builds a field for a single gradient stop, which includes a draggable thumb and a label showing the stop's position.
class GradientStopField extends StatefulWidget {
  final GradientStop stop;
  final double width;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueChanged<double> onDrag;

  const GradientStopField({
    super.key,
    required this.stop,
    required this.width,
    required this.onTap,
    required this.onLongPress,
    required this.onDrag,
  });

  @override
  State<GradientStopField> createState() => _GradientStopFieldState();
}

class _GradientStopFieldState extends State<GradientStopField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  double get _center => widget.width * widget.stop.position / 100;
  double get _labelLeft => (_center - GradientEditorMetrics.labelWidth / 2)
      .clamp(0, widget.width - GradientEditorMetrics.labelWidth);

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Thumb (draggable) ----------------------------------------------
        Positioned(
          left: _center - GradientEditorMetrics.thumbWidth / 2,
          top: GradientEditorMetrics.thumbTop,
          width: GradientEditorMetrics.thumbWidth,
          height: GradientEditorMetrics.thumbHeight,
          child: Focus(
            focusNode: _focusNode,
            onFocusChange: (focused) => setState(() => _isFocused = focused),
            child: GestureDetector(
              onTap: widget.onTap,
              onLongPress: widget.onLongPress,
              onHorizontalDragStart: (_) => _focusNode.requestFocus(),
              onHorizontalDragUpdate: (details) =>
                  widget.onDrag(details.globalPosition.dx),
              onHorizontalDragEnd: (_) => _focusNode.unfocus(),
              child: AnimatedScale(
                scale: _isFocused ? GradientEditorMetrics.focusScale : 1,
                duration: AppDurations.fast,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.stop.color,
                    border: Border.all(
                      color: _isFocused
                          ? context.colors.primary
                          : context.colors.outline,
                      width: _isFocused
                          ? AppSizes.borderWidthThick
                          : AppSizes.borderWidthThin,
                    ),
                    borderRadius: AppRadius.borderRadiusSm,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Tag (percentage) ----------------------------------------------
        Positioned(
          left: _labelLeft,
          top: GradientEditorMetrics.labelTop,
          width: GradientEditorMetrics.labelWidth,
          height: GradientEditorMetrics.labelHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outlineVariant),
              borderRadius: AppRadius.borderRadiusSm,
            ),
            child: Center(
              child: Text(
                '${widget.stop.position}%',
                style: context.textTheme.labelMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
