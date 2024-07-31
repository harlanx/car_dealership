import 'package:flutter/material.dart';

import '../../../data/app_data.dart';
import '../../../utilities/utilities.dart';

class HomeCopyrightBar extends StatelessWidget {
  const HomeCopyrightBar({
    super.key,
    required this.size,
  });
  final Size size;

  bool get _screenLarge {
    final sWidth = size.width;
    return sWidth >= 1280;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppData.color,
            width: 2.0,
          ),
        ),
      ),
      width: double.infinity,
      child: Wrap(
        direction: Axis.horizontal,
        alignment:
            _screenLarge ? WrapAlignment.spaceBetween : WrapAlignment.center,
        children: const [
          SelectableText(
              '© Copyright 2024 Silvian Automobile PH. All Rights Reserved.'),
          WebLink(text: 'Privacy Policy'),
        ],
      ),
    );
  }
}
