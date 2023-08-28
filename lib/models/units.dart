// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod/riverpod.dart';

class Units {
  final String temperatureUnit;
  final String pressureUnit;
  final String windSpeedUnit;
  Units(
      {required this.temperatureUnit,
      required this.pressureUnit,
      required this.windSpeedUnit});

  Units copyWith({
    String? temperatureUnit,
    String? pressureUnit,
    String? windSpeedUnit,
  }) {
    return Units(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      pressureUnit: pressureUnit ?? this.pressureUnit,
      windSpeedUnit: windSpeedUnit ?? this.windSpeedUnit,
    );
  }
}

class UnitsNotifier extends StateNotifier<Units> {
  UnitsNotifier()
      : super(Units(
            temperatureUnit: 'Celsius',
            pressureUnit: 'mBar',
            windSpeedUnit: 'km/h'));

  void updateTemperatureUnit(String temperatureUnit) {
    state = state.copyWith(temperatureUnit: temperatureUnit);
  }

  void updatePressureUnit(String pressureUnit) {
    state = state.copyWith(pressureUnit: pressureUnit);
  }

  void updateWindSpeedUnit(String windSpeedUnit) {
    state = state.copyWith(windSpeedUnit: windSpeedUnit);
  }
}

final unitsProvider =
    StateNotifierProvider<UnitsNotifier, Units>((ref) => UnitsNotifier());
