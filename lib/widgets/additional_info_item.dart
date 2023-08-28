import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const AdditionalInfoItem(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
