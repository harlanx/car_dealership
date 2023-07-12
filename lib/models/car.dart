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

  Car(
    String name,
    DateTime dateReleased,
    double price,
    this.maxSpeed,
    this.horsePower,
  ) : super(modelName: name, dateReleased: dateReleased, price: price);
}

class CarHighlight implements Car {
  @override
  String modelName;

  @override
  DateTime dateReleased;

  @override
  double horsePower;

  @override
  double maxSpeed;

  @override
  double price;

  List<String> preview;

  String description;

  CarHighlight({
    required this.modelName,
    required this.dateReleased,
    required this.maxSpeed,
    required this.horsePower,
    this.price = 0.0,
    required this.preview,
    required this.description,
  });
}
