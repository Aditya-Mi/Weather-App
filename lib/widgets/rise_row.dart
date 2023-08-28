import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiseRow extends StatelessWidget {
  final String image;
  final String text;
  const RiseRow({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            image,
            height: 48,
            width: 48,
            fit: BoxFit.scaleDown,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
