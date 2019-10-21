import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ShadowIcon extends StatelessWidget {
  ShadowIcon(this.data,
      {this.shadowColor = Colors.black,
      this.offsetX = 2.0,
      this.offsetY = 2.0,
      this.blur = 2.0})
      : assert(data != null);

  final IconData data;
  final Color shadowColor;
  final double offsetX;
  final double offsetY;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: offsetX,
            left: offsetY,
            child: Icon(
              data,
              color: shadowColor,
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Icon(data),
          ),
        ],
      ),
    );
  }
}