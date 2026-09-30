import 'package:image_picker/image_picker.dart';

/// Static wrapper on `image_picker`.
class ImagePickerService {
  ImagePickerService._();

  static final ImagePicker _picker = ImagePicker();

  /// Abre la galería y devuelve la ruta de la imagen elegida.
  static Future<String?> fromGallery({
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
  }) {
    return _pick(
      ImageSource.gallery,
      imageQuality: imageQuality,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  }

  /// Abre la cámara y devuelve la ruta de la foto tomada.
  static Future<String?> fromCamera({
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) {
    return _pick(
      ImageSource.camera,
      imageQuality: imageQuality,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      preferredCameraDevice: preferredCameraDevice,
    );
  }

  static Future<String?> _pick(
    ImageSource source, {
    required int imageQuality,
    double? maxWidth,
    double? maxHeight,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    final XFile? file = await _picker.pickImage(
      source: source,
      imageQuality: imageQuality,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      preferredCameraDevice: preferredCameraDevice,
    );
    return file?.path;
  }
}
