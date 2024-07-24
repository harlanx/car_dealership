import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../data/app_data.dart';
import '../../../utilities/utilities.dart';

class HomeLineup extends StatefulWidget {
  const HomeLineup({super.key, required this.size});
  final Size size;

  @override
  State<HomeLineup> createState() => _HomeLineupState();
}

class _HomeLineupState extends State<HomeLineup>
    with SingleTickerProviderStateMixin {
  final _carouselController = CustomCarouselController();
  var _currentIndex = 0;

  double get _viewPort {
    final sWidth = widget.size.width;
    double val = 0.24;
    if (sWidth > 1280) {
      val = 0.24;
    } else if (sWidth > 900 && sWidth < 1280) {
      val = 0.3;
    } else if (sWidth > 800 && sWidth < 900) {
      val = 0.38;
    } else if (sWidth > 600 && sWidth < 800) {
      val = 0.45;
    } else {
      val = 0.55;
    }
    return val;
  }

  int get _vicinityRange {
    final sWidth = widget.size.width;
    int val = 0;
    if (sWidth >= 900) val = 1;

    return val;
  }

  bool get _screenLarge {
    final sWidth = widget.size.width;
    return sWidth >= 1280;
  }

  bool _isInVicinity(int index) {
    final listLength = carLineup.length;
    if (listLength <= 1) return false;
    final range = _vicinityRange;

    final int lowerBound = (_currentIndex - range + listLength) % listLength;
    final int upperBound = (_currentIndex + range) % listLength;

    if (lowerBound <= upperBound) {
      return index >= lowerBound && index <= upperBound;
    } else {
      return index >= lowerBound || index <= upperBound;
    }
  }

  int _rangeIndex(int index, int offset) {
    final listLength = carLineup.length;
    int newIndex = (index + offset) % listLength;

    if (newIndex < 0) {
      newIndex += listLength;
    }

    return newIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 400,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  scrollPhysics: _screenLarge
                      ? const NeverScrollableScrollPhysics()
                      : const ScrollPhysics(),
                  enableInfiniteScroll: true,
                  viewportFraction: _viewPort,
                  autoPlayCurve: Curves.easeInOutCubic,
                  clipBehavior: Clip.antiAlias,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: List.from(
                  carLineup.mapIndexed(
                    (index, car) => CarLineup(
                      index: index,
                      currentIndex: _currentIndex,
                      enabled: _isInVicinity(index),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _screenLarge,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PolyButton(
                          onPressed: () {
                            _carouselController.animateToPage(
                              _rangeIndex(_currentIndex, -3),
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(seconds: 1),
                            );
                          },
                          style: PolyButtonStyle(
                            borderColor: AppData.color,
                            initialColor: Colors.white,
                            childColor: AppData.color,
                            endColor: AppData.color,
                            endChildColor: Colors.white,
                            borderSize: 1.5,
                            size: 30,
                          ),
                          child: const Icon(Icons.arrow_back_ios_sharp),
                        ),
                        PolyButton(
                          onPressed: () {
                            _carouselController.animateToPage(
                              _rangeIndex(_currentIndex, 3),
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(seconds: 1),
                            );
                          },
                          style: PolyButtonStyle(
                            borderColor: AppData.color,
                            initialColor: Colors.white,
                            childColor: AppData.color,
                            endColor: AppData.color,
                            endChildColor: Colors.white,
                            borderSize: 1.5,
                            size: 30,
                          ),
                          child: const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //TODO: Add Explore our lineup, get a quote, check out price list
        Row(),
      ],
    );
  }
}

class CarLineup extends StatefulWidget {
  const CarLineup({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.enabled,
  });

  final int index;
  final int currentIndex;
  final bool enabled;

  @override
  State<CarLineup> createState() => _CarLineupState();
}

class _CarLineupState extends State<CarLineup>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));
  late final Animation<Color?> _animation =
      ColorTween(begin: Colors.black, end: Colors.white).animate(_controller);

  late final car = carLineup[widget.index];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      key: ValueKey(car),
      cursor: SystemMouseCursors.click,
      onEnter: (e) {
        if (widget.enabled) _controller.forward();
      },
      onExit: (e) {
        if (widget.enabled) _controller.reverse();
      },
      child: Opacity(
        opacity: widget.enabled ? 1 : 0.5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            Animate(
              controller: _controller,
              autoPlay: false,
              effects: const [
                SlideEffect(
                  begin: Offset(0, 1),
                  end: Offset.zero,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.fastOutSlowIn,
                ),
                FadeEffect(
                  duration: Duration(milliseconds: 150),
                  curve: Curves.fastOutSlowIn,
                ),
              ],
              child: Center(
                child: SizedBox(
                  width: 320,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      // Car Background
                      Image.asset(
                        car.preview[1],
                        fit: BoxFit.cover,
                      ),
                      // Black Gradient
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x00000000),
                              Color(0xff000000),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.3),
              child: Image.asset(
                car.preview.first,
                height: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, _) {
                        return Text(
                          car.modelName,
                          style: TextStyle(
                            color: _animation.value,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                        );
                      },
                    ),
                    Text(
                      'From: ₱${NumberFormat("#,##0").format(car.price)}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
