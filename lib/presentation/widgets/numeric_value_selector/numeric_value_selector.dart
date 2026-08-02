import 'package:flutter/material.dart';
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
  /// Valor inicial del contador.
  final int initialValue;

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
    this.initialValue = 0,
    this.decrementStep = 1,
    this.incrementStep = 1,
    this.minValue = 0,
    this.maxValue = 100,
    this.onChanged,
  }) : assert(
         initialValue >= minValue && initialValue <= maxValue,
         'initialValue debe estar entre minValue y maxValue',
       ),
       assert(minValue <= maxValue, 'minValue no puede ser mayor que maxValue'),
       assert(decrementStep > 0, 'decrementStep debe ser mayor que 0'),
       assert(incrementStep > 0, 'incrementStep debe ser mayor que 0');

  @override
  State<NumericValueSelector> createState() => _NumericValueSelectorState();
}

class _NumericValueSelectorState extends State<NumericValueSelector> {
  late int _currentValue = widget.initialValue;
  late final TextEditingController _textController = TextEditingController(
    text: _currentValue.toString(),
  );

  /// Número de divisiones del slider, de modo que se mueva en pasos de 1.
  int? get _sliderDivisions {
    final int range = widget.maxValue - widget.minValue;
    return range > 0 ? range : null;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            StepButton(
              symbol: '−',
              onPressed: _currentValue > widget.minValue
                  ? _decrementValue
                  : null,
            ),
            Expanded(
              child: SliderTheme(
                data: Theme.of(context).sliderTheme.copyWith(
                  activeTrackColor: colorScheme.primary,
                  thumbColor: colorScheme.primary,
                ),
                child: Slider(
                  value: _currentValue.toDouble(),
                  min: widget.minValue.toDouble(),
                  max: widget.maxValue.toDouble(),
                  divisions: _sliderDivisions,
                  label: '$_currentValue',
                  onChanged: (double value) => _applyValue(value.round()),
                ),
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
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          width: 100,
          child: TextField(
            controller: _textController,
            onChanged: _applyTypedValue,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(isDense: true),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
