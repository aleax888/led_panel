import 'package:flutter/material.dart';
import 'package:led_panel/theme/app_theme.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Theme',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: ThemeShowcasePage(onToggleTheme: _toggleTheme),
    );
  }
}

class ThemeShowcasePage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const ThemeShowcasePage({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Showcase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
            tooltip: 'Cambiar tema',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            _GradientHeader(textTheme: textTheme),
            const SizedBox(height: AppSpacing.lg),

            Text('Headline Large', style: textTheme.headlineLarge),
            const SizedBox(height: AppSpacing.xs),
            Text('Headline Small', style: textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Este es un bodyMedium de ejemplo mostrando cómo se ve el '
              'texto secundario con el theme aplicado a toda la app.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),

            Text('Botones', style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                TextButton(onPressed: () {}, child: const Text('Text')),
                const ElevatedButton(onPressed: null, child: Text('Disabled')),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            Text('Input', style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Escribe tu nombre',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text('Card', style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Text(
                  'Este card usa AppColors, AppRadius y AppSpacing.',
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GradientHeader extends StatelessWidget {
  final TextTheme textTheme;

  const _GradientHeader({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.buttonHeightLg * 2,
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.borderRadiusLg,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        'Gradiente de marca #DCE35B → #45B649',
        style: textTheme.titleLarge?.copyWith(color: AppColors.white),
      ),
    );
  }
}
