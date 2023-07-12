import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/app_data.dart';
import '../../models/car.dart';
import '../../utilities/utilities.dart';

class HomeHighlight extends StatefulWidget {
  const HomeHighlight({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  State<HomeHighlight> createState() => _HomeHighlightState();
}

class _HomeHighlightState extends State<HomeHighlight>
    with SingleTickerProviderStateMixin {
  final _carouselController = CustomCarouselController();

  double get _aRatio {
    final sWidth = widget.size.width;
    double val = 5 / 2;
    if (sWidth > 1280) {
      val = 5 / 2;
    } else if (sWidth > 600 && sWidth < 1280) {
      val = 3 / 2;
    } else {
      val = 2.5 / 2;
    }

    return val;
  }

  bool get _screenLarge {
    final sWidth = widget.size.width;
    return sWidth >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: AspectRatio(
        aspectRatio: _aRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                initialPage: 2,
                scrollDirection: Axis.horizontal,
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
                    carouselController: _carouselController,
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
                      _carouselController.previousPage();
                    },
                    style: PolyButtonStyle(
                      borderColor: AppData.color,
                      endChildColor: Colors.white,
                      endColor: AppData.color,
                      size: 60,
                    ),
                    child: const Icon(Icons.arrow_back_ios_sharp),
                  ),
                  PolyButton(
                    onPressed: () {
                      _carouselController.nextPage();
                    },
                    style: PolyButtonStyle(
                      borderColor: AppData.color,
                      endChildColor: Colors.white,
                      endColor: AppData.color,
                      size: 60,
                    ),
                    child: const Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _carouselController.onReady,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SmoothPageIndicator(
                        controller: _carouselController.state!.pageController!,
                        count: _carouselController.state!.itemCount!,
                        onDotClicked: (val) {
                          _carouselController.animateToPage(val - 1);
                        },
                        effect: SlideEffect(
                          activeDotColor: AppData.color,
                          paintStyle: PaintingStyle.stroke,
                          spacing: 10,
                          dotWidth: 20,
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
      ),
    );
  }
}

class CarHighlightBox extends StatefulWidget {
  const CarHighlightBox({
    Key? key,
    required this.carouselController,
    required this.car,
    required this.screenLarge,
  }) : super(key: key);

  final CarouselController carouselController;
  final CarHighlight car;
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
