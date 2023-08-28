import 'package:flutter/material.dart';

class HourlyItem extends StatelessWidget {
  final String hour;
  final IconData icon;
  final String temp;
  const HourlyItem(
      {super.key, required this.hour, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hour,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 14,
          ),
          Icon(
            icon,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            temp,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
