import 'package:flutter/material.dart';

extension WidgetListExt on List<Widget> {
  /// Insert [widget] between each member of this list
  List<Widget> insertBetween(Widget widget) {
    if (length > 1) {
      for (var i = length - 1; i > 0; i--) {
        insert(i, widget);
      }
    }

    return this;
  }
}

extension LocaleExtension on Locale {
  // Update also when adding new locales
  String get name {
    switch (languageCode) {
      case 'en':
        return 'English';

      case 'fil':
        return 'Filipino';
      default:
        return '';
    }
  }

  // Note: Use NotoColorEmoji (Windows Compatible) since some OS like windows doesn't support (render) flag emojis
  // https://github.com/googlefonts/noto-emoji/tree/main/fonts
  String get flagEmoji {
    switch (languageCode) {
      case 'en':
        return _getFlagEmoji('GB');
      case 'fil':
        return _getFlagEmoji('PH');
      default:
        return '🏳️';
    }
  }

  static String _getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }
}
