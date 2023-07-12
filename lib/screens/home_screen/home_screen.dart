import 'package:flutter/material.dart';

import 'package:sliver_tools/sliver_tools.dart';

import '../../screens/home_screen/home_header.dart';
import '../../screens/home_screen/home_highlight.dart';
import 'home_extra.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final ScrollController _scHeader = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scHeader,
        shrinkWrap: true,
        slivers: [
          const HomeExtra(),
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
                      for (var i in Colors.primaries)
                        Center(
                          child: Container(
                            color: i,
                            constraints: const BoxConstraints(maxWidth: 1280),
                            height: 200,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SliverPinnedHeader(
                child: HomeHeader(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
