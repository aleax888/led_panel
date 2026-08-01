import 'package:flutter/material.dart';

/// Un widget que permite seleccionar una cantidad mediante controles de incremento/decremento.
///
/// Proporciona tres elementos:
/// - Un botón "-" para decrementar
/// - Un campo de texto que muestra la cantidad actual
/// - Un botón "+" para incrementar
///
/// La cantidad de cambio en cada incremento/decremento es personalizable,
/// así como los valores mínimo y máximo permitidos.
class QuantityCounter extends StatefulWidget {
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

  /// Color de los botones de incremento/decremento.
  final Color? buttonColor;

  /// Color del texto en los botones.
  final Color? buttonTextColor;

  /// Tamaño del texto en los botones.
  final double buttonTextSize;

  /// Ancho del campo de texto.
  final double textFieldWidth;

  /// Radio de los bordes del widget.
  final double borderRadius;

  const QuantityCounter({
    Key? key,
    this.initialValue = 0,
    this.decrementStep = 1,
    this.incrementStep = 1,
    this.minValue = 0,
    this.maxValue = 100,
    this.onChanged,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonTextSize = 24,
    this.textFieldWidth = 80,
    this.borderRadius = 8,
  })  : assert(initialValue >= minValue && initialValue <= maxValue,
            'initialValue debe estar entre minValue y maxValue'),
        assert(minValue <= maxValue, 'minValue no puede ser mayor que maxValue'),
        assert(decrementStep > 0, 'decrementStep debe ser mayor que 0'),
        assert(incrementStep > 0, 'incrementStep debe ser mayor que 0'),
        super(key: key);

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  late int _currentValue;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _textController = TextEditingController(text: _currentValue.toString());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Decrementa el valor actual en [widget.decrementStep].
  /// No permite que el valor sea menor que [widget.minValue].
  void _decrementValue() {
    int newValue = _currentValue - widget.decrementStep;
    newValue = newValue.clamp(widget.minValue, widget.maxValue);
    _updateValue(newValue);
  }

  /// Incrementa el valor actual en [widget.incrementStep].
  /// No permite que el valor sea mayor que [widget.maxValue].
  void _incrementValue() {
    int newValue = _currentValue + widget.incrementStep;
    newValue = newValue.clamp(widget.minValue, widget.maxValue);
    _updateValue(newValue);
  }

  /// Actualiza el valor actual y notifica el cambio.
  void _updateValue(int newValue) {
    setState(() {
      _currentValue = newValue;
      _textController.text = _currentValue.toString();
    });
    widget.onChanged?.call(_currentValue);
  }

  /// Valida y actualiza el valor cuando el usuario lo escribe directamente.
  void _onTextFieldChanged(String value) {
    if (value.isEmpty) return;

    int? parsedValue = int.tryParse(value);
    if (parsedValue != null) {
      int newValue = parsedValue.clamp(widget.minValue, widget.maxValue);
      setState(() {
        _currentValue = newValue;
        _textController.text = _currentValue.toString();
      });
      widget.onChanged?.call(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.buttonColor ?? Colors.blue;
    final buttonTextColor = widget.buttonTextColor ?? Colors.white;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Botón de decremento
          Material(
            color: buttonColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius),
              bottomLeft: Radius.circular(widget.borderRadius),
            ),
            child: InkWell(
              onTap: _decrementValue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                bottomLeft: Radius.circular(widget.borderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '−',
                  style: TextStyle(
                    color: buttonTextColor,
                    fontSize: widget.buttonTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Campo de texto
          SizedBox(
            width: widget.textFieldWidth,
            child: TextField(
              controller: _textController,
              onChanged: _onTextFieldChanged,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),

          // Botón de incremento
          Material(
            color: buttonColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(widget.borderRadius),
              bottomRight: Radius.circular(widget.borderRadius),
            ),
            child: InkWell(
              onTap: _incrementValue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(widget.borderRadius),
                bottomRight: Radius.circular(widget.borderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '+',
                  style: TextStyle(
                    color: buttonTextColor,
                    fontSize: widget.buttonTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
