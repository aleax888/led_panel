import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

class ShareHandler {
  ShareHandler._();

  /// Comparte texto plano.
  static Future<ShareResult> shareText(
    String text, {
    String? subject,
    BuildContext? context,
  }) {
    return SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: subject,
        sharePositionOrigin: _originFrom(context),
      ),
    );
  }

  /// Comparte una URL (Android/iOS la tratan como enlace).
  static Future<ShareResult> shareUri(Uri uri, {BuildContext? context}) {
    return SharePlus.instance.share(
      ShareParams(uri: uri, sharePositionOrigin: _originFrom(context)),
    );
  }

  /// Comparte uno o varios archivos, con texto opcional.
  static Future<ShareResult> shareFiles(
    List<XFile> files, {
    String? text,
    String? subject,
    BuildContext? context,
  }) {
    return SharePlus.instance.share(
      ShareParams(
        files: files,
        text: text,
        subject: subject,
        sharePositionOrigin: _originFrom(context),
      ),
    );
  }

  /// Comparte un archivo a partir de su ruta local.
  static Future<ShareResult> shareFilePath(
    String path, {
    String? text,
    String? subject,
    BuildContext? context,
  }) {
    return shareFiles(
      [XFile(path)],
      text: text,
      subject: subject,
      context: context,
    );
  }

  /// Indica si el usuario completó la acción de compartir.
  static bool isSuccess(ShareResult result) =>
      result.status == ShareResultStatus.success;

  /// En iPad/macOS el menú necesita un punto de origen; lo calculamos
  /// desde el widget que disparó la acción. Devuelve null si no hay contexto.
  static Rect? _originFrom(BuildContext? context) {
    if (context == null || !context.mounted) return null;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }
}
