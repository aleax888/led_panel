part of 'image_cubit.dart';

@immutable
final class ImageState {
  final ImageConfigModel config;
  const ImageState({ImageConfigModel? config})
    : config = config ?? const ImageConfigModel();

  ImageState copyWith({ImageConfigModel? config}) {
    return ImageState(config: config ?? this.config);
  }
}
