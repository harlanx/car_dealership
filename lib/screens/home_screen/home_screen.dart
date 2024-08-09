import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'content/home_pinned_extra.dart';
import 'content/home_header.dart';
import 'content/home_highlight.dart';
import 'content/home_lineup.dart';
import 'content/home_news.dart';
import 'content/home_bottom_info.dart';
import 'content/home_copyright_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        shrinkWrap: true,
        slivers: [
          const HomePinnedExtra(), // SliverAppbar
          // The body is affacted when header is expanded
          // PinnedHeaderSliver(child: HomeHeader(size: size)),
          // SliverToBoxAdapter(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       HomeHighlight(size: size),
          //       HomeLineup(size: size),
          //       HomeNews(size: size),
          //       HomeBottomInfo(size: size),
          //       HomeCopyrightBar(size: size),
          //     ],
          //   ),
          // ),
          // The body is not affect when header is expanded
          SliverStack(
            insetOnOverlap: false,
            children: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HomeHighlight(size: size),
                      HomeLineup(size: size),
                      HomeNews(size: size),
                      HomeBottomInfo(size: size),
                      HomeCopyrightBar(size: size),
                    ],
                  ),
                ),
              ),
              SliverPinnedHeader(child: HomeHeader(size: size)),
            ],
          ),
        ],
      ),
    );
  }
}
