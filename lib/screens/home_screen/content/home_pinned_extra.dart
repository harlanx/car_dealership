import 'package:flutter/material.dart';

import '../../../data/app_data.dart';
import '../../../utilities/utilities.dart';

class HomePinnedExtra extends StatefulWidget {
  const HomePinnedExtra({super.key});

  @override
  State<HomePinnedExtra> createState() => _HomePinnedExtraState();
}

class _HomePinnedExtraState extends State<HomePinnedExtra> {
  var isFocused = List<bool>.filled(5, false);
  final _divider = const SizedBox(
    height: 15,
    child: VerticalDivider(
      color: Colors.white,
      thickness: 1.5,
      width: 15,
      //thickness: 1,
    ),
  );
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    return SliverAppBar(
      //expandedHeight: 20,
      toolbarHeight: 40,
      backgroundColor: AppData.colorSwatch,
      centerTitle: true,
      shape: const Border(
        bottom: BorderSide(color: Colors.white, width: 2.0),
      ),
      title: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: AppData.maxWidthConstraints),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SelectableText(
                        'Call or Email Us Today',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const WebLink(text: '+63 911 222 3333'),
                      _divider,
                      const WebLink(text: 'business@mailservice.com'),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widthSize > 900.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 15),
                    WebLink(
                      text: 'Service Portal',
                      onTap: () {},
                    ),
                    _divider,
                    WebLink(
                      text: 'Client Portal',
                      onTap: () {},
                    ),
                    _divider,
                    WebLink(
                      text: 'Service Status',
                      onTap: () {},
                    ),
                    // const SizedBox(width: 15),
                    // const LanguageOptionTray(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
