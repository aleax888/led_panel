import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/backgrounds/image/image_cubit.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/background_fields.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/utils/image_getter.dart';

/// Class that builds the image fields for the image background configuration.
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

    return [
      Row(
        children: [
          // Image from camera ----------------------------------------------
          Expanded(
            child: Container(
              width: .infinity,
              height: AppSizes.buttonHeightXl,
              padding: AppSpacing.screenPadding,
              child: ElevatedButton(
                onPressed: () async => _updateUrl(
                  await ImagePickerService.fromCamera(),
                  imageCubit,
                ),
                child: Icon(Icons.camera_alt_outlined, size: AppSizes.iconLg),
              ),
            ),
          ),
          // Image from gallery ----------------------------------------------
          Expanded(
            child: Container(
              width: .infinity,
              height: AppSizes.buttonHeightXl,
              padding: AppSpacing.screenPadding,
              child: ElevatedButton(
                onPressed: () async => _updateUrl(
                  await ImagePickerService.fromGallery(),
                  imageCubit,
                ),
                child: Icon(
                  Icons.photo_library_outlined,
                  size: AppSizes.iconLg,
                ),
              ),
            ),
          ),
          // Image from internet ----------------------------------------------
          Expanded(
            child: Container(
              width: .infinity,
              height: AppSizes.buttonHeightXl,
              padding: AppSpacing.screenPadding,
              child: ElevatedButton(
                onPressed: () async => _updateUrl(
                  await showDialog<String?>(
                    context: context,
                    builder: (_) => _GetUrlDialog(),
                  ),
                  imageCubit,
                ),
                child: Icon(Icons.link, size: AppSizes.iconLg),
              ),
            ),
          ),

          // Opacity ----------------------------------------------
          // TODO
        ],
      ),
    ];
  }

  @override
  BackgroundConfigModel currentConfig(BuildContext context) =>
      context.read<ImageCubit>().state.config;

  void _updateUrl(String? url, ImageCubit imageCubit) {
    if (url?.isNotEmpty == true) {
      imageCubit.onUrlChanged(url!);
    }
  }
}

/// Displays a dialog for confirming deletion of a saved configuration.
class _GetUrlDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  _GetUrlDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale.fromNetwork,
        style: context.textTheme.titleMedium,
      ),
      content: TextFormField(
        controller: controller,
        onEditingComplete: () => Focus.of(context).unfocus(),
        onTapOutside: (event) => Focus.of(context).unfocus(),
        maxLines: 2,
        minLines: 1,
        decoration: InputDecoration(hintText: context.locale.pasteYourUrl),
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      actions: [
        // Cancel ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(
            context.locale.cancel,
            style: context.textTheme.labelLarge,
          ),
        ),

        // Delete ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: Text(
            context.locale.done,
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
