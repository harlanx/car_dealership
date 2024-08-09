import 'package:flutter/material.dart';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/app_data.dart';
import '../../../models/models.dart';
import '../../../utilities/utilities.dart';

class HomeHighlight extends StatefulWidget {
  const HomeHighlight({super.key, required this.size});
  final Size size;

  @override
  State<HomeHighlight> createState() => _HomeHighlightState();
}

class _HomeHighlightState extends State<HomeHighlight>
    with SingleTickerProviderStateMixin {
  final _customController = CustomCarouselController();

  double get _aRatio {
    final sWidth = widget.size.width;
    double val = 5 / 2;
    if (sWidth > 1280) {
      val = 5 / 2;
    } else if (sWidth > 1000 && sWidth < 1280) {
      val = 3 / 2;
    } else {
      val = 2.5 / 2;
    }

    return val;
  }

  bool get _screenLarge {
    return widget.size.width >= 1280;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _aRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            controller: _customController,
            options: CarouselOptions(
              initialPage: 2,
              scrollDirection: Axis.horizontal,
              scrollPhysics: _screenLarge
                  ? const NeverScrollableScrollPhysics()
                  : const ScrollPhysics(),
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              aspectRatio: _aRatio,
              autoPlayCurve: Curves.easeInOutCubic,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 1),
            ),
            items: [
              for (var car in carHighlights)
                CarHighlightBox(
                  carouselController: _customController,
                  car: car,
                  screenLarge: _screenLarge,
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PolyButton(
                  onPressed: () {
                    _customController.previousPage(
                      curve: Curves.easeInOutCubic,
                      duration: const Duration(seconds: 1),
                    );
                  },
                  style: PolyButtonStyle(
                    borderColor: AppData.color,
                    endChildColor: Colors.white,
                    endColor: AppData.color,
                    size: _screenLarge ? 60 : 30,
                  ),
                  child: const Icon(Icons.arrow_back_ios_sharp),
                ),
                PolyButton(
                  onPressed: () {
                    _customController.nextPage(
                      curve: Curves.easeInOutCubic,
                      duration: const Duration(seconds: 1),
                    );
                  },
                  style: PolyButtonStyle(
                    borderColor: AppData.color,
                    endChildColor: Colors.white,
                    endColor: AppData.color,
                    size: _screenLarge ? 60 : 30,
                  ),
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _customController.onReady,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: EdgeInsets.only(bottom: _screenLarge ? 10.0 : 2.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: _customController.state!.pageController!,
                      count: _customController.state!.itemCount!,
                      onDotClicked: (val) {
                        _customController.animateToPage(
                          val - 1,
                          curve: Curves.easeInOutCubic,
                          duration: const Duration(seconds: 1),
                        );
                      },
                      effect: SlideEffect(
                        activeDotColor: AppData.color,
                        paintStyle: PaintingStyle.stroke,
                        dotHeight: _screenLarge ? 16 : 8,
                        dotWidth: _screenLarge ? 20 : 8,
                        dotColor: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class CarHighlightBox extends StatefulWidget {
  const CarHighlightBox({
    super.key,
    required this.carouselController,
    required this.car,
    required this.screenLarge,
  });

  final CarouselSliderController carouselController;
  final CarProduct car;
  final bool screenLarge;

  @override
  State<CarHighlightBox> createState() => _CarHighlightBoxState();
}

class _CarHighlightBoxState extends State<CarHighlightBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late final Animation _scaleAnimation = Tween(begin: 1.0, end: 1.1)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  late final Animation _tintAnimation =
      ColorTween(begin: Colors.transparent, end: Colors.black.withOpacity(0.3))
          .animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
        widget.carouselController.stopAutoPlay();
      },
      onExit: (_) {
        _controller.reverse();
        widget.carouselController.startAutoPlay();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Image.asset(
                    widget.car.preview[0],
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                );
              }),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                color: _tintAnimation.value,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.6, -1.5),
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
                radius: 3.5,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SelectableText(
                          widget.car.modelName.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'ZenKakuGothicAntique',
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SelectableText(
                        widget.car.description.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'ZenKakuGothicAntique',
                          fontSize: 90,
                          fontWeight: FontWeight.w900,
                          height: 0.8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.screenLarge) ...[
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: widget.screenLarge ? 50 : 20,
                  left: 60,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PolyButton(
                      onPressed: () {},
                      style: PolyButtonStyle(
                        borderColor: AppData.color,
                        borderSize: 1.5,
                        endChildColor: Colors.white,
                        endColor: AppData.color,
                        size: 40,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Explore the model',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ] else ...[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: widget.screenLarge ? 50 : 20, right: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PolyButton(
                      onPressed: () {},
                      style: PolyButtonStyle(
                        borderColor: AppData.color,
                        borderSize: 1.5,
                        endChildColor: Colors.white,
                        endColor: AppData.color,
                        size: 20,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 15,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Explore the model',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20, right: 20, bottom: widget.screenLarge ? 50 : 10),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 150,
                  minWidth: 400,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var preview in widget.car.preview)
                      Flexible(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Image.asset(
                              preview,
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ]..insertBetween(
                      SizedBox(
                        width: widget.screenLarge ? 15 : 5,
                      ),
                    ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
