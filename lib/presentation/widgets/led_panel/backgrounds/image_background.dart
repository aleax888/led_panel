import 'package:flutter/material.dart';

import 'package:led_panel/data/models/led_panel/background_configs/image_config_model.dart';

class ImageBackground extends StatelessWidget {
  final ImageConfigModel config;

  const ImageBackground({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.network(
        config.url ?? '',
        fit: .cover,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox.expand(
            child: ColoredBox(
              color: Colors.grey,
              child: Center(
                child: Icon(Icons.broken_image_outlined, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
