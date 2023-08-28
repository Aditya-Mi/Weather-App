import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/units.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final units = ref.watch(unitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 28, 16, 46),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 28, 16, 46),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            DropdownButton<String>(
              underline: const SizedBox(),
              isExpanded: true,
              icon: const Icon(Icons.arrow_forward_ios),
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Temperature',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      units.temperatureUnit,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 87, 61, 134),
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              items: <String>['Celsius', 'Farenheit']
                  .map<DropdownMenuItem<String>>(
                    (temperatureUnit) => DropdownMenuItem<String>(
                      value: temperatureUnit,
                      child: Text(
                        temperatureUnit,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: ((value) {
                if (value == null) {
                  return;
                }
                ref.read(unitsProvider.notifier).updateTemperatureUnit(value);
              }),
            ),
            DropdownButton<String>(
              underline: const SizedBox(),
              isExpanded: true,
              icon: const Icon(Icons.arrow_forward_ios),
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Pressure',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      units.pressureUnit,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 87, 61, 134),
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              items: <String>['mBar', 'in']
                  .map<DropdownMenuItem<String>>(
                    (pressureUnit) => DropdownMenuItem<String>(
                      value: pressureUnit,
                      child: Text(
                        pressureUnit,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: ((value) {
                if (value == null) {
                  return;
                }
                ref.read(unitsProvider.notifier).updatePressureUnit(value);
              }),
            ),
            DropdownButton<String>(
              underline: const SizedBox(),
              isExpanded: true,
              icon: const Icon(Icons.arrow_forward_ios),
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Wind Speed',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      units.windSpeedUnit,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 87, 61, 134),
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              items: <String>['km/h', 'mph']
                  .map<DropdownMenuItem<String>>(
                    (windSpeedUnit) => DropdownMenuItem<String>(
                      value: windSpeedUnit,
                      child: Text(
                        windSpeedUnit,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: ((value) {
                if (value == null) {
                  return;
                }
                ref.read(unitsProvider.notifier).updateWindSpeedUnit(value);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
