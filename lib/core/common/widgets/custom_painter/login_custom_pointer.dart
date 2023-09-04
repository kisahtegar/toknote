// ignore_for_file: omit_local_variable_types, non_constant_identifier_names, prefer_final_locals, cascade_invocations, prefer_const_constructors, lines_longer_than_80_chars

import 'package:flutter/material.dart';

/// A custom painter that draws a stylized top background for a login screen.
class LoginTopCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Square 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 23, 108, 174)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0016625, size.height * -0.0053200);
    path_0.lineTo(size.width * 0.0000875, size.height * -0.0053200);
    path_0.quadraticBezierTo(
      size.width * 0.0000875,
      size.height * 0.5966800,
      size.width * 0.0000875,
      size.height * 0.7973600,
    );
    path_0.cubicTo(
      size.width * 0.4173125,
      size.height * 0.2994800,
      size.width * 0.4985000,
      size.height * 1.1148000,
      size.width * 1.0016625,
      size.height * 0.8013600,
    );
    path_0.quadraticBezierTo(
      size.width * 1.0016625,
      size.height * 0.5996800,
      size.width * 1.0016625,
      size.height * -0.0053200,
    );
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Square 1 Border

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(0, 243, 33, 33)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);

    // Square 2

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(178, 0, 135, 239)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 1.0018750, size.height * -0.0020000);
    path_1.lineTo(size.width * 0.0003000, size.height * -0.0020000);
    path_1.quadraticBezierTo(
      size.width * 0.0003000,
      size.height * 0.4938792,
      size.width * 0.0003000,
      size.height * 0.6591723,
    );
    path_1.cubicTo(
      size.width * 0.4175250,
      size.height * 0.2490656,
      size.width * 0.4980750,
      size.height * 0.7246800,
      size.width * 1.0012375,
      size.height * 0.4664800,
    );
    path_1.quadraticBezierTo(
      size.width * 1.0012375,
      size.height * 0.3004000,
      size.width * 1.0018750,
      size.height * -0.0020000,
    );
    path_1.close();

    canvas.drawPath(path_1, paint_fill_1);

    // Square 2 Border

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// A custom painter that draws a stylized bottom background for a login screen.
class LoginBottomCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Square 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 23, 108, 174)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0016625, size.height * 0.9999600);
    path_0.lineTo(size.width * 0.9999125, size.height * 0.9999600);
    path_0.quadraticBezierTo(
      size.width * 0.9999125,
      size.height * 0.3980000,
      size.width * 0.9999125,
      size.height * 0.1972800,
    );
    path_0.cubicTo(
      size.width * 0.5826875,
      size.height * 0.6951600,
      size.width * 0.5015000,
      size.height * -0.1201200,
      size.width * -0.0016625,
      size.height * 0.1932800,
    );
    path_0.quadraticBezierTo(
      size.width * -0.0016625,
      size.height * 0.3950000,
      size.width * -0.0016625,
      size.height * 0.9999600,
    );
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Square 1 Border

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(0, 243, 33, 33)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);

    // Square 2

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(178, 0, 135, 239)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 1.0018750, size.height * 1.0020000);
    path_1.lineTo(size.width * 0.0003000, size.height * 1.0020000);
    path_1.quadraticBezierTo(
      size.width * 0.0003000,
      size.height * 0.5061208,
      size.width * 0.0003000,
      size.height * 0.3408277,
    );
    path_1.cubicTo(
      size.width * 0.4175250,
      size.height * 0.7509344,
      size.width * 0.4980750,
      size.height * 0.2753200,
      size.width * 1.0012375,
      size.height * 0.5335200,
    );
    path_1.quadraticBezierTo(
      size.width * 1.0012375,
      size.height * 0.6996000,
      size.width * 1.0018750,
      size.height * 1.0020000,
    );
    path_1.close();

    canvas.drawPath(path_1, paint_fill_1);

    // Square 2 Border

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
