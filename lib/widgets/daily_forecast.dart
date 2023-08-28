import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyForecast extends StatelessWidget {
  final String day;
  final IconData icon;
  final String maxTemp;
  final String minTemp;
  const DailyForecast(
      {super.key,
      required this.day,
      required this.icon,
      required this.maxTemp,
      required this.minTemp});

  @override
  Widget build(BuildContext context) {
    final daily = DateTime.parse(day);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat.EEEE().format(daily),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Icon(icon),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Text(maxTemp, style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  minTemp,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 87, 61, 134),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
