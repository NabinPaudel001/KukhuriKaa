import 'package:flutter/material.dart';

class SensorDataProvider with ChangeNotifier {
  double _temperature = 24; // Initial temperature value
  double _humidity = 80; // Initial humidity value

  double get temperature => _temperature;
  double get humidity => _humidity;

  void updateTemperature(double value) {
    _temperature = value;
    notifyListeners();
  }

  void updateHumidity(double value) {
    _humidity = value;
    notifyListeners();
  }
}
