import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Class that builds a dialog for selecting the stop position in a gradient editor.
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
      title: Text(
        context.locale.stopPosition,
        style: context.textTheme.titleLarge,
      ),
      content: NumericValueSelector(
        label: context.locale.position,
        unit: '%',
        value: _position,
        minValue: 0,
        maxValue: 100,
        onChanged: (value) => setState(() => _position = value),
      ),
      actions: [
        // Cancel ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.locale.cancel),
        ),

        // Add ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_position),
          child: Text(context.locale.add),
        ),
      ],
    );
  }
}
