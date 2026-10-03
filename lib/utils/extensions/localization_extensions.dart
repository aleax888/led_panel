import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/enums/crawl_direction_enum.dart';
import 'package:led_panel/data/enums/dot_shape_enum.dart';
import 'package:led_panel/data/enums/locale_enum.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/l10n/app_localizations.dart';

extension AnimationTypeLocalization on AnimationTypeEnum {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    AnimationTypeEnum.none => l10n.animationNone,
    AnimationTypeEnum.marquee => l10n.animationMarquee,
    AnimationTypeEnum.typewriter => l10n.animationTypewriter,
    AnimationTypeEnum.wave => l10n.animationWave,
    AnimationTypeEnum.scramble => l10n.animationScramble,
    AnimationTypeEnum.crawl => l10n.animationCrawl,
  };
}

extension BackgroundTypeLocalization on BackgroundTypeEnum {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    BackgroundTypeEnum.solidColor => l10n.backgroundSolid,
    BackgroundTypeEnum.linearGradient => l10n.backgroundGradient,
    BackgroundTypeEnum.image => l10n.backgroundImage,
  };
}

extension CrawlDirectionLocalization on CrawlTextDirectionEnum {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    CrawlTextDirectionEnum.toBottom => l10n.directionToBottom,
    CrawlTextDirectionEnum.toTop => l10n.directionToTop,
  };
}

extension MarqueeDirectionLocalization on MarqueeDirectionEnum {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    MarqueeDirectionEnum.toLeft => l10n.directionLeft,
    MarqueeDirectionEnum.toRight => l10n.directionRight,
  };
}

extension DotShapeLocalization on DotShapeEnum {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    DotShapeEnum.circle => l10n.shapeCircle,
    DotShapeEnum.square => l10n.shapeSquare,
    DotShapeEnum.diamond => l10n.shapeDiamond,
    DotShapeEnum.star => l10n.shapeStar,
    DotShapeEnum.cross => l10n.shapeCross,
    DotShapeEnum.heart => l10n.shapeHeart,
  };
}

extension LocaleEnumLocalization on LocaleEnum {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    LocaleEnum.es => l10n.localeSpanish,
    LocaleEnum.en => l10n.localeEnglish,
    LocaleEnum.pt => l10n.localePortuguese,
    LocaleEnum.fr => l10n.localeFrench,
    LocaleEnum.de => l10n.localeGerman,
    LocaleEnum.it => l10n.localeItalian,
  };
}
