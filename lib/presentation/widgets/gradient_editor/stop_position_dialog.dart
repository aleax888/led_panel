import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class StopPositionDialog extends StatefulWidget {
  const StopPositionDialog({super.key});

  @override
  State<StopPositionDialog> createState() => _StopPositionDialogState();
}

class _StopPositionDialogState extends State<StopPositionDialog> {
  int _position = 50;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Stop position'),
      content: NumericValueSelector(
        label: 'Position',
        unit: '%',
        value: _position,
        minValue: 0,
        maxValue: 100,
        onChanged: (value) => setState(() => _position = value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_position),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
