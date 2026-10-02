import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/locale/locale_cubit.dart';
import 'package:led_panel/presentation/widgets/locale_selector/locale_selector.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// A dialog widget that allows users to select a locale from a list of available locales.
class LocaleSelectionDialog extends StatelessWidget {
  const LocaleSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    return AlertDialog(
      title: Text('Locale', style: context.textTheme.titleLarge),
      content: SizedBox(
        width: double.maxFinite,
        child: LocaleSelector(
          selectedLocale: localeCubit.state.locale,
          onChanged: (locale) {
            localeCubit.changeLocaleMode(locale);
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        // Cancel ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: context.textTheme.labelLarge),
        ),

        // Done button ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Done'),
        ),
      ],
    );
  }
}
