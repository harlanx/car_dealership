import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../data/app_data.dart';
import '../../../models/models.dart';
import '../../../utilities/utilities.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  bool get _screenLarge {
    return widget.size.width >= 1280;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppData.color,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'NEWSROOM',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
          ),
          MasonryGridView.count(
            itemCount: newsHeadlines.length,
            crossAxisSpacing: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            crossAxisCount: _screenLarge ? 3 : 2,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            itemBuilder: (context, index) {
              return NewsBox(
                news: newsHeadlines[index],
                screenLarge: _screenLarge,
              );
            },
          ),
        ],
      ),
    );
  }
}

class NewsBox extends StatefulWidget {
  const NewsBox({
    super.key,
    required this.news,
    required this.screenLarge,
  });
  final News news;
  final bool screenLarge;

  @override
  State<NewsBox> createState() => _NewsBoxState();
}

class _NewsBoxState extends State<NewsBox> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  late final _backgroundColor = ColorTween(
    begin: Colors.white,
    end: Colors.black,
  ).animate(_controller);

  late final _textColor = ColorTween(
    begin: Colors.black,
    end: Colors.white,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        _controller.forward();
      },
      onExit: (event) {
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: () {},
        child: AnimatedBuilder(
            animation: _backgroundColor,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                    color: _backgroundColor.value,
                    border: Border.all(
                      color: _backgroundColor.value!,
                      width: 2.0,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.news.image != null) ...[
                      Image.asset(widget.news.image!)
                    ],
                    Flexible(
                      child: AnimatedBuilder(
                        animation: _textColor,
                        builder: (context, _) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    widget.news.headline,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: _textColor.value,
                                      fontSize: widget.screenLarge ? 18 : 15,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    widget.news.description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: widget.screenLarge ? 2 : 3,
                                    style: TextStyle(
                                      color: _textColor.value,
                                      fontSize: widget.screenLarge ? 15 : 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: WebLink(
                          text: 'Read More >>',
                          color: AppData.color,
                          hoverColor: AppData.color,
                          underline: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
