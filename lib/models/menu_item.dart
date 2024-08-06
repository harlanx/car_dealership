import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../utilities/utilities.dart';
import 'models.dart';

class MenuItem {
  MenuItem({
    required this.label,
    this.content,
    this.menuChild,
    required this.controller,
    this.context,
  });

  final String label;
  final List<MenuContentItem>? content;
  final Widget? menuChild;
  final AnimationController controller;
  BuildContext? context;

  bool get hasContent => content != null;
}

class MenuContentItem {
  MenuContentItem({
    required this.label,
    this.url,
    this.items,
    this.generateItems = false,
    this.generateCar = false,
    this.car,
  }) {
    if (generateItems) {
      items = List.generate(
        RandomHelper.randRangeInt(2, 5),
        (index) {
          final randomCar = carLineup[RandomHelper.randRangeInt(0, 21)];
          return MenuContentItem(
            label: randomCar.modelName,
            generateCar: true,
          );
        },
      );
    }
    if (generateCar) {
      url = '';
      car = carLineup[RandomHelper.randRangeInt(0, 21)];
    }
  }

  final String label;
  String? url;
  final bool generateItems;
  List<MenuContentItem>? items;
  final bool generateCar;
  CarProduct? car;
}
