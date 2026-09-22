import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/utils/app_info_getter.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: AppInfoGetter.getVersion(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Text('v-.-.-', style: context.textTheme.labelSmall);
        } else {
          return Text('v${snapshot.data}', style: context.textTheme.labelSmall);
        }
      },
    );
  }
}
