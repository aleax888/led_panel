import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:led_panel/data/models/led_panel/background_configs/image_config_model.dart';
import 'package:led_panel/theme/constants/app_durations.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';

/// An enum representing the different types of image sources that can be used for the LED panel background.
enum _ImageSourceType { network, asset, file, none }

/// A widget that displays an image background for a LED panel, supporting different image sources (network, asset, file).
class ImageBackground extends StatelessWidget {
  final ImageConfigModel config;

  const ImageBackground({super.key, required this.config});

  /// Resolves the image source type based on the provided URL or path.
  static _ImageSourceType _resolveSource(String value) {
    if (value.isEmpty) return _ImageSourceType.none;

    final uri = Uri.tryParse(value);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      return _ImageSourceType.network;
    }
    if (value.startsWith('assets/')) return _ImageSourceType.asset;

    // Local paths: /storage/..., /data/user/..., file:///...
    return _ImageSourceType.file;
  }

  @override
  Widget build(BuildContext context) {
    final value = (config.url ?? '').trim();
    final source = _resolveSource(value);

    return SizedBox.expand(
      child: switch (source) {
        _ImageSourceType.network => Image.network(
          value,
          fit: .cover,
          loadingBuilder: _loadingBuilder,
          errorBuilder: _errorBuilder,
        ),
        _ImageSourceType.asset => Image.asset(
          value,
          fit: .cover,
          frameBuilder: _frameBuilder,
          errorBuilder: _errorBuilder,
        ),
        _ImageSourceType.file when !kIsWeb => Image.file(
          value.startsWith('file://')
              ? File.fromUri(Uri.parse(value))
              : File(value),
          fit: .cover,
          frameBuilder: _frameBuilder,
          errorBuilder: _errorBuilder,
        ),
        _ => const _ImagePlaceholder(
          child: Icon(Icons.broken_image_outlined, size: AppSizes.iconXl),
        ),
      },
    );
  }

  /// Displays a loading indicator while the image is being loaded from the network.
  static Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? progress,
  ) {
    if (progress == null) return child;

    final total = progress.expectedTotalBytes;
    return _ImagePlaceholder(
      child: CircularProgressIndicator(
        value: total != null ? progress.cumulativeBytesLoaded / total : null,
      ),
    );
  }

  /// Displays a fade-in effect for images that are loaded from assets or files.
  static Widget _frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) return child;

    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: AppDurations.slow,
      curve: Curves.easeOut,
      child: child,
    );
  }

  /// Displays a placeholder with an error icon when the image fails to load.
  static Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return const _ImagePlaceholder(
      child: Icon(Icons.broken_image_outlined, size: AppSizes.iconXl),
    );
  }
}

/// A private widget that serves as a placeholder for the image background, displaying a grey box with a centered child widget (e.g., an icon or loading indicator).
class _ImagePlaceholder extends StatelessWidget {
  final Widget child;

  const _ImagePlaceholder({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: Colors.grey,
        child: Center(child: child),
      ),
    );
  }
}
