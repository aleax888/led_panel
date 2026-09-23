import 'package:flutter/material.dart';
import 'package:led_panel/data/models/animations/crawl_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_text.dart';

class CrawlText extends StatefulWidget {
  final TextConfigModel textConfig;
  final CrawlConfigModel animationConfig;
  const CrawlText({
    super.key,
    required this.textConfig,
    required this.animationConfig,
  });

  @override
  State<CrawlText> createState() => _CrawlTextState();
}

class _CrawlTextState extends State<CrawlText> {
  @override
  Widget build(BuildContext context) {
    return StyledText(textConfig: widget.textConfig);
  }
}
