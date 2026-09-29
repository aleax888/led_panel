import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/backgrounds/image/image_cubit.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/background_fields.dart';

class ImageFields implements BackgroundFields {
  const ImageFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(BackgroundConfigModel) sync,
  ) {
    final imageCubit = context.watch<ImageCubit>();
    imageCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = imageCubit.state.config;

    return [
      // Image ----------------------------------------------
      
    ];
  }

  @override
  BackgroundConfigModel currentConfig(BuildContext context) =>
      context.read<ImageCubit>().state.config;
}
