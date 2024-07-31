import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as img;

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

extension StringEx on String {
  Size textSize({
    required TextStyle? style,
    int maxLines = 1,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: this, style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }
}

extension ImageEx on Image {
  static Future<MemoryImage> assetCropped(
    String path,
    double x,
    y,
    size,
  ) async {
    // Flutter web doesn't support dart:io so we manually load the asset
    // Make sure to call WidgetsFlutterBinding.ensureInitialized(); in main method to use rootBundle.
    final bytes = (await rootBundle.load(path)).buffer.asUint8List();

    final decoded = img.PngDecoder().decode(bytes);
    if (decoded == null) return Future.error('Cannot decode image file');

    final cropped =
        img.copyCrop(decoded, x: x.toInt(), y: y, width: size, height: size);

    // Have to re-encode using this package to make it to work
    // Not sure why it doesn't work when directly accessing getBytes();
    final encoded = img.encodePng(cropped, level: 1, singleFrame: true);

    final result = MemoryImage(encoded);

    return result;
  }
}
