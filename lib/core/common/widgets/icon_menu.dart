import 'package:flutter/material.dart';
import 'package:toknote/core/res/colours.dart';

class IconMenu extends StatelessWidget {
  const IconMenu({
    required this.image,
    required this.imageSize,
    required this.title,
    required this.description,
    this.onTap,
    super.key,
  });

  final String image;
  final double imageSize;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 70,
        height: 85,
        child: Column(
          children: [
            Image.asset(
              image,
              width: imageSize,
              height: imageSize,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
