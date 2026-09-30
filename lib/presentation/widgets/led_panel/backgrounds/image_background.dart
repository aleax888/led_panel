import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:led_panel/data/models/led_panel/background_configs/image_config_model.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';

enum _ImageSourceType { network, asset, file, none }

class ImageBackground extends StatelessWidget {
  final ImageConfigModel config;

  const ImageBackground({super.key, required this.config});

  /// Decide de dónde viene la imagen según el formato del string.
  static _ImageSourceType _resolveSource(String value) {
    if (value.isEmpty) return _ImageSourceType.none;

    final uri = Uri.tryParse(value);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      return _ImageSourceType.network;
    }
    if (value.startsWith('assets/')) return _ImageSourceType.asset;

    // Rutas locales: /storage/..., /data/user/..., file:///...
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
          fit: BoxFit.cover,
          loadingBuilder: _loadingBuilder,
          errorBuilder: _errorBuilder,
        ),
        _ImageSourceType.asset => Image.asset(
          value,
          fit: BoxFit.cover,
          frameBuilder: _frameBuilder,
          errorBuilder: _errorBuilder,
        ),
        // Image.file no está soportado en web.
        _ImageSourceType.file when !kIsWeb => Image.file(
          value.startsWith('file://')
              ? File.fromUri(Uri.parse(value))
              : File(value),
          fit: BoxFit.cover,
          frameBuilder: _frameBuilder,
          errorBuilder: _errorBuilder,
        ),
        _ => const _ImagePlaceholder(
          child: Icon(Icons.broken_image_outlined, size: AppSizes.iconXl),
        ),
      },
    );
  }

  /// Solo para Image.network: muestra el progreso de descarga.
  static Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? progress,
  ) {
    if (progress == null) return child;

    final total = progress.expectedTotalBytes;
    return _ImagePlaceholder(
      child: CircularProgressIndicator(
        // null => indicador indeterminado si el servidor no envía el tamaño.
        value: total != null ? progress.cumulativeBytesLoaded / total : null,
      ),
    );
  }

  /// Para asset/file: fade-in suave cuando el primer frame está listo.
  static Widget _frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) return child;

    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: child,
    );
  }

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
