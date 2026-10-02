import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'LED PANEL'**
  String get appName;

  /// No description provided for @customization.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMIZATION'**
  String get customization;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get home;

  /// No description provided for @newConfig.
  ///
  /// In en, this message translates to:
  /// **'+ NEW'**
  String get newConfig;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'TEXT'**
  String get text;

  /// No description provided for @anim.
  ///
  /// In en, this message translates to:
  /// **'ANIM'**
  String get anim;

  /// No description provided for @bg.
  ///
  /// In en, this message translates to:
  /// **'BG'**
  String get bg;

  /// No description provided for @leds.
  ///
  /// In en, this message translates to:
  /// **'LEDs'**
  String get leds;

  /// No description provided for @recents.
  ///
  /// In en, this message translates to:
  /// **'RECENTS'**
  String get recents;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'FAVORITES'**
  String get favorites;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'ANIMATION'**
  String get animation;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'BACKGROUND'**
  String get background;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'DIRECTION'**
  String get direction;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'COLOR'**
  String get color;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select color'**
  String get selectColor;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @typeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeYourMessage;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'SIZE'**
  String get size;

  /// No description provided for @glow.
  ///
  /// In en, this message translates to:
  /// **'GLOW'**
  String get glow;

  /// No description provided for @letterSpacing.
  ///
  /// In en, this message translates to:
  /// **'LETTER SPACING'**
  String get letterSpacing;

  /// No description provided for @wordSpacing.
  ///
  /// In en, this message translates to:
  /// **'WORD SPACING'**
  String get wordSpacing;

  /// No description provided for @ledsSize.
  ///
  /// In en, this message translates to:
  /// **'SIZE'**
  String get ledsSize;

  /// No description provided for @ledsPadding.
  ///
  /// In en, this message translates to:
  /// **'PADDING'**
  String get ledsPadding;

  /// No description provided for @ledsShape.
  ///
  /// In en, this message translates to:
  /// **'SHAPE'**
  String get ledsShape;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'SPEED'**
  String get speed;

  /// No description provided for @tilt.
  ///
  /// In en, this message translates to:
  /// **'TILT'**
  String get tilt;

  /// No description provided for @characterDuration.
  ///
  /// In en, this message translates to:
  /// **'CHARACTER DURATION'**
  String get characterDuration;

  /// No description provided for @completionPause.
  ///
  /// In en, this message translates to:
  /// **'COMPLETION PAUSE'**
  String get completionPause;

  /// No description provided for @scrambleCharacters.
  ///
  /// In en, this message translates to:
  /// **'SCRAMBLE CHARACTERS'**
  String get scrambleCharacters;

  /// No description provided for @characterDurationNoise.
  ///
  /// In en, this message translates to:
  /// **'CHARACTER DURATION NOISE'**
  String get characterDurationNoise;

  /// No description provided for @amplitude.
  ///
  /// In en, this message translates to:
  /// **'AMPLITUDE'**
  String get amplitude;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'FREQUENCY'**
  String get frequency;

  /// No description provided for @phaseStep.
  ///
  /// In en, this message translates to:
  /// **'PHASE STEP'**
  String get phaseStep;

  /// No description provided for @font.
  ///
  /// In en, this message translates to:
  /// **'FONT'**
  String get font;

  /// No description provided for @addStop.
  ///
  /// In en, this message translates to:
  /// **'Add stop'**
  String get addStop;

  /// No description provided for @stopPosition.
  ///
  /// In en, this message translates to:
  /// **'Stop position'**
  String get stopPosition;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @fromNetwork.
  ///
  /// In en, this message translates to:
  /// **'From network'**
  String get fromNetwork;

  /// No description provided for @pasteYourUrl.
  ///
  /// In en, this message translates to:
  /// **'Paste your URL...'**
  String get pasteYourUrl;

  /// No description provided for @locale.
  ///
  /// In en, this message translates to:
  /// **'Locale'**
  String get locale;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get language;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'SHARE APP'**
  String get shareApp;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'THEME'**
  String get theme;

  /// No description provided for @lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get lock;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @deleteConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Delete configuration'**
  String get deleteConfiguration;

  /// No description provided for @deleteConfigurationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this?\nThis action cannot be undone.'**
  String get deleteConfigurationMessage;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addToFavorites;

  /// No description provided for @emptyItems.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any items yet'**
  String get emptyItems;

  /// No description provided for @animationNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get animationNone;

  /// No description provided for @animationMarquee.
  ///
  /// In en, this message translates to:
  /// **'Marquee'**
  String get animationMarquee;

  /// No description provided for @animationTypewriter.
  ///
  /// In en, this message translates to:
  /// **'Typewriter'**
  String get animationTypewriter;

  /// No description provided for @animationWave.
  ///
  /// In en, this message translates to:
  /// **'Wave'**
  String get animationWave;

  /// No description provided for @animationScramble.
  ///
  /// In en, this message translates to:
  /// **'Scramble'**
  String get animationScramble;

  /// No description provided for @animationCrawl.
  ///
  /// In en, this message translates to:
  /// **'Crawl'**
  String get animationCrawl;

  /// No description provided for @backgroundSolid.
  ///
  /// In en, this message translates to:
  /// **'Solid'**
  String get backgroundSolid;

  /// No description provided for @backgroundGradient.
  ///
  /// In en, this message translates to:
  /// **'Gradient'**
  String get backgroundGradient;

  /// No description provided for @backgroundImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get backgroundImage;

  /// No description provided for @directionToBottom.
  ///
  /// In en, this message translates to:
  /// **'To bottom'**
  String get directionToBottom;

  /// No description provided for @directionToTop.
  ///
  /// In en, this message translates to:
  /// **'To top'**
  String get directionToTop;

  /// No description provided for @directionLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get directionLeft;

  /// No description provided for @directionRight.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get directionRight;

  /// No description provided for @shapeCircle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get shapeCircle;

  /// No description provided for @shapeSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get shapeSquare;

  /// No description provided for @shapeDiamond.
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get shapeDiamond;

  /// No description provided for @shapeStar.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get shapeStar;

  /// No description provided for @shapeCross.
  ///
  /// In en, this message translates to:
  /// **'Cross'**
  String get shapeCross;

  /// No description provided for @shapeHeart.
  ///
  /// In en, this message translates to:
  /// **'Heart'**
  String get shapeHeart;

  /// No description provided for @localeSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get localeSpanish;

  /// No description provided for @localeEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get localeEnglish;

  /// No description provided for @noDateAvailable.
  ///
  /// In en, this message translates to:
  /// **'No date available'**
  String get noDateAvailable;

  /// No description provided for @rightNow.
  ///
  /// In en, this message translates to:
  /// **'Right now'**
  String get rightNow;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
