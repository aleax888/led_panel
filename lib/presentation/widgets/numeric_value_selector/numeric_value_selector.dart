import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/step_button.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Un widget que permite seleccionar una cantidad mediante un slider.
///
/// El control principal es un [Slider], acompañado de:
/// - Un botón "−" a la izquierda para decrementar en [decrementStep].
/// - Un botón "+" a la derecha para incrementar en [incrementStep].
/// - Un campo de texto para digitar el valor exacto a mano.
///
/// Las tres formas de interacción están sincronizadas: cambiar el valor
/// desde cualquiera de ellas actualiza a las demás.
class NumericValueSelector extends StatefulWidget {
  /// Label
  final String label;

  /// Measurement unit
  final String? unit;

  /// Valor inicial del contador.
  final int value;

  /// Cantidad en la que decrementa el botón "-".
  final int decrementStep;

  /// Cantidad en la que incrementa el botón "+".
  final int incrementStep;

  /// Valor mínimo permitido. El contador no puede ir por debajo de esto.
  final int minValue;

  /// Valor máximo permitido. El contador no puede exceder esto.
  final int maxValue;

  /// Callback que se dispara cuando la cantidad cambia.
  /// Recibe el nuevo valor como parámetro.
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
         'initialValue debe estar entre minValue y maxValue',
       ),
       assert(minValue <= maxValue, 'minValue no puede ser mayor que maxValue'),
       assert(decrementStep > 0, 'decrementStep debe ser mayor que 0'),
       assert(incrementStep > 0, 'incrementStep debe ser mayor que 0');

  @override
  State<NumericValueSelector> createState() => _NumericValueSelectorState();
}

class _NumericValueSelectorState extends State<NumericValueSelector> {
  late int _currentValue = widget.value;
  late final TextEditingController _textController = TextEditingController(
    text: _currentValue.toString(),
  );

  /// Número de divisiones del slider, de modo que se mueva en pasos de 1.
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
          crossAxisAlignment: .start,
          children: [
            Expanded(child: InputLabel(label: widget.label)),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _textController,
                onChanged: _applyTypedValue,
                keyboardType: .number,
                textAlign: .end,
                decoration: InputDecoration(
                  isDense: true,
                  suffix: widget.unit != null ? Text(' ${widget.unit}') : null,
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Row(
          children: [
            StepButton(
              symbol: '−',
              onPressed: _currentValue > widget.minValue
                  ? _decrementValue
                  : null,
            ),
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

  /// Aplica un nuevo valor proveniente del slider o de los botones,
  /// y sincroniza el campo de texto con el resultado.
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

  /// Aplica un valor digitado a mano. Solo reescribe el campo de texto
  /// si el valor tuvo que ajustarse a los límites, para no interrumpir
  /// al usuario mientras sigue escribiendo.
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
