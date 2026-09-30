import 'package:led_panel/data/models/led_panel/background_configs/image_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit({final ImageConfigModel? config})
    : super(ImageState(config: config));

  void onUrlChanged(String url) {
    emit(state.copyWith(config: state.config.copyWith(url: url)));
  }
}
