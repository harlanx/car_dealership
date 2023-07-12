import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../extensions.dart';

class LanguageOptionTray extends StatefulWidget {
  const LanguageOptionTray({Key? key}) : super(key: key);

  @override
  State<LanguageOptionTray> createState() => _LanguageOptionTrayState();
}

class _LanguageOptionTrayState extends State<LanguageOptionTray>
    with TickerProviderStateMixin {
  late final supportedLocales =
      context.findAncestorWidgetOfExactType<MaterialApp>()!.supportedLocales;
  late final _controllers = <String, AnimationController>{
    for (var locale in supportedLocales)
      locale.languageCode: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 150),
      ),
  };
  late final _animations = <String, Animation<Color?>>{
    for (var locale in supportedLocales)
      locale.languageCode: ColorTween(
              begin: DefaultTextStyle.of(context).style.color, end: Colors.grey)
          .animate(_controllers[locale.languageCode]!)
  };

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers.entries) {
      if (AppData.selectedLocale != controller.key) {
        controller.value.forward();
      } else {
        controller.value.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var locale in supportedLocales)
          MouseRegion(
            onEnter: (_) {
              if (locale.languageCode != AppData.selectedLocale) {
                _controllers[locale.languageCode]!.reverse();
              }
            },
            onExit: (_) {
              if (locale.languageCode != AppData.selectedLocale) {
                _controllers[locale.languageCode]!.forward();
              }
            },
            child: AnimatedBuilder(
                animation: _animations[locale.languageCode]!,
                builder: (context, child) {
                  return Text.rich(
                    TextSpan(
                      text: '${locale.flagEmoji} ${locale.languageCode}',
                      style: TextStyle(
                          color: _animations[locale.languageCode]!.value),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppData.selectedLocale = locale.languageCode;
                          _controllers.entries
                              .singleWhere((controller) =>
                                  controller.key == AppData.selectedLocale)
                              .value
                              .reverse();

                          for (var controller in _controllers.entries.where(
                              (ctrl) => ctrl.key != AppData.selectedLocale)) {
                            controller.value.forward();
                          }
                        },
                    ),
                  );
                }),
          ),
      ]..insertBetween(_divider),
    );
  }

  final _divider = const SizedBox(
    height: 15,
    child: VerticalDivider(
      color: Colors.white,
      thickness: 1.5,
      width: 15,
      //thickness: 1,
    ),
  );
}
