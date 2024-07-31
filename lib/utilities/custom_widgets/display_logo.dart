import 'package:flutter/material.dart';

import '../utilities.dart';

class DisplayLogo extends StatefulWidget {
  const DisplayLogo({
    super.key,
    required this.path,
    this.size = 25,
    required this.x,
    required this.y,
  });

  final String path;
  final double size, x, y;

  @override
  State<DisplayLogo> createState() => _DisplayLogoState();
}

class _DisplayLogoState extends State<DisplayLogo> {
  late final Future<MemoryImage> _future;

  @override
  void initState() {
    super.initState();
    _future = ImageEx.assetCropped(
      widget.path,
      widget.x,
      widget.y,
      widget.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FutureBuilder(
        future: _future,
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: Image(
                  image: snapshot.data!,
                ),
              ),
            );
          }
          // return Text(snapshot.error.toString());
          return const FlutterLogo(
            size: 25,
            style: FlutterLogoStyle.horizontal,
          );
        },
      ),
    );
  }
}
