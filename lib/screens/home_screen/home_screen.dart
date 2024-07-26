import 'package:flutter/material.dart';

import 'package:sliver_tools/sliver_tools.dart';

import 'content/home_pinned_extra.dart';
import 'content/home_header.dart';
import 'content/home_highlight.dart';
import 'content/home_lineup.dart';
import 'content/home_news.dart';
import 'content/home_bottom_info.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ScrollController _scHeader = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scHeader,
        shrinkWrap: true,
        slivers: [
          const HomePinnedExtra(),
          SliverStack(
            insetOnOverlap: true,
            children: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HomeHighlight(size: MediaQuery.of(context).size),
                      HomeLineup(size: MediaQuery.of(context).size),
                      HomeNews(size: MediaQuery.of(context).size),
                      const HomeBottomInfo(),
                    ],
                  ),
                ),
              ),
              const SliverPinnedHeader(child: HomeHeader()),
            ],
          ),
        ],
      ),
    );
  }
}
