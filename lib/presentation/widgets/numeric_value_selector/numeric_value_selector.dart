import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/step_button.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Provides synchronized slider, step button, and text field value controls.
class NumericValueSelector extends StatefulWidget {
  final String label;
  final String? unit;
  final int value;
  final int decrementStep;
  final int incrementStep;
  final int minValue;
  final int maxValue;
  final ValueChanged<int>? onChanged;

  const NumericValueSelector({
    super.key,
    required this.label,
    this.unit,
    this.value = 0,
    this.decrementStep = 1,
    this.incrementStep = 1,
    this.minValue = 0,
    this.maxValue = 100,
    this.onChanged,
  }) : assert(
         value >= minValue && value <= maxValue,
         'initialValue must be between minValue and maxValue',
       ),
       assert(minValue <= maxValue, 'minValue cannot be greater than maxValue'),
       assert(decrementStep > 0, 'decrementStep must be greater than 0'),
       assert(incrementStep > 0, 'incrementStep must be greater than 0');

  @override
  State<NumericValueSelector> createState() => _NumericValueSelectorState();
}

class _NumericValueSelectorState extends State<NumericValueSelector> {
  late int _currentValue = widget.value;
  late final TextEditingController _textController = TextEditingController(
    text: _currentValue.toString(),
  );

  int? get _sliderDivisions {
    final int range = widget.maxValue - widget.minValue;
    return range > 0 ? range : null;
  }

  @override
  void didUpdateWidget(covariant NumericValueSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        _currentValue = widget.value;
        _textController.text = _currentValue.toString();
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: [
        Row(
          spacing: AppSpacing.sm,
          crossAxisAlignment: .start,
          children: [
            // Label ----------------------------------------------
            Expanded(child: InputLabel(label: widget.label)),

            // Text input ----------------------------------------------
            Expanded(
              flex: 2,
              child: TextField(
                controller: _textController,
                onChanged: _applyTypedValue,
                keyboardType: .number,
                textAlign: .end,
                decoration: InputDecoration(
                  isDense: true,
                  suffix: widget.unit != null
                      ? Text(
                          ' ${widget.unit}',
                          style: context.textTheme.labelMedium,
                        )
                      : null,
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Row(
          children: [
            // Decrement input ----------------------------------------------
            StepButton(
              symbol: '−',
              onPressed: _currentValue > widget.minValue
                  ? _decrementValue
                  : null,
            ),

            // Slider input ----------------------------------------------
            Expanded(
              child: Slider(
                value: _currentValue.toDouble(),
                min: widget.minValue.toDouble(),
                max: widget.maxValue.toDouble(),
                divisions: _sliderDivisions,
                label: '$_currentValue',
                onChanged: (double value) => _applyValue(value.round()),
              ),
            ),

            // Increment input ----------------------------------------------
            StepButton(
              symbol: '+',
              onPressed: _currentValue < widget.maxValue
                  ? _incrementValue
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  /// Applies a value from the slider or buttons and synchronizes the text field.
  void _applyValue(int newValue) {
    final int clampedValue = newValue.clamp(widget.minValue, widget.maxValue);
    setState(() {
      _currentValue = clampedValue;
      _textController.text = clampedValue.toString();
    });
    widget.onChanged?.call(clampedValue);
  }

  void _decrementValue() => _applyValue(_currentValue - widget.decrementStep);

  void _incrementValue() => _applyValue(_currentValue + widget.incrementStep);

  /// Applies a manually entered value, updating the field only when clamping
  /// is needed so typing is not interrupted.
  void _applyTypedValue(String rawValue) {
    if (rawValue.isEmpty) return;

    final int? typedValue = int.tryParse(rawValue);
    if (typedValue == null) return;

    final int clampedValue = typedValue.clamp(widget.minValue, widget.maxValue);
    setState(() => _currentValue = clampedValue);
    widget.onChanged?.call(clampedValue);

    if (clampedValue != typedValue) {
      _textController
        ..text = clampedValue.toString()
        ..selection = TextSelection.collapsed(
          offset: _textController.text.length,
        );
    }
  }
}
