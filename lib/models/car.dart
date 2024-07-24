import '../../../utilities/utilities.dart';

abstract class Vehicle {
  String modelName;
  DateTime dateReleased;
  double price;

  Vehicle({
    required this.modelName,
    required this.dateReleased,
    required this.price,
  });
}

class Car extends Vehicle {
  double maxSpeed;
  double horsePower;

  Car({
    required this.maxSpeed,
    required this.horsePower,
    required super.modelName,
    required super.dateReleased,
    required super.price,
  });
}

class CarProduct extends Car {
  List<String> preview;
  String description;

  CarProduct({
    required super.modelName,
    required this.preview,
    this.description = '',
    super.price = 0.0,
    super.maxSpeed = 0.0,
    super.horsePower = 0.0,
  }) : super(
          dateReleased:
              RandomHelper.randDateTime(DateTime(2015), DateTime(2030)),
        ) {
    price = RandomHelper.randRangeDouble(200000, 3500000);
    maxSpeed = RandomHelper.randRangeInt(120, 215).toDouble();
    horsePower = RandomHelper.randRangeInt(215, 800).toDouble();
  }
}
