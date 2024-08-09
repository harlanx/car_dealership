import 'package:carousel_slider_plus/carousel_controller.dart';
import 'package:carousel_slider_plus/carousel_state.dart';

class CustomCarouselController extends CarouselSliderController {
  CarouselState? _state;
  CarouselState? get state => _state;

  @override
  set state(CarouselState? state) {
    _state = state;
    super.state = state;
  }
}
