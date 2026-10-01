import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart' show XFile;

/// Servicio para convertir un widget en imagen.
abstract final class WidgetCaptureHandler {
  WidgetCaptureHandler._();

  static Future<ui.Image?> toImage(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    var needsPaint = false;
    assert(() {
      needsPaint = boundary.debugNeedsPaint;
      return true;
    }());
    if (needsPaint) {
      await WidgetsBinding.instance.endOfFrame;
    }

    return await boundary.toImage(pixelRatio: pixelRatio);
  }

  static Future<Uint8List?> toPngBytes(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    final image = await toImage(key, pixelRatio: pixelRatio);
    if (image == null) return null;

    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return data?.buffer.asUint8List();
    } catch (e, st) {
      debugPrint('WidgetCaptureService.toPngBytes error: $e\n$st');
      return null;
    } finally {
      image.dispose();
    }
  }

  static Future<XFile?> toXFile(
    GlobalKey key, {
    double pixelRatio = 3.0,
    String name = 'captura.png',
  }) async {
    final bytes = await toPngBytes(key, pixelRatio: pixelRatio);
    if (bytes == null) return null;
    return XFile.fromData(bytes, mimeType: 'image/png', name: name);
  }
}
