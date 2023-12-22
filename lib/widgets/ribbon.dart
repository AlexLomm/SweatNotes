import 'package:flutter/material.dart';
import 'dart:math' as math;

enum RibbonLocation {
  topStart,
  topEnd,
  bottomStart,
  bottomEnd,
}

class Ribbon extends StatelessWidget {
  final double nearLength;
  final double farLength;
  final String title;
  final Color color;
  final TextStyle titleStyle;
  final RibbonLocation location;
  final BoxShadow? boxShadow;
  final Widget child;

  const Ribbon({
    super.key,
    required this.nearLength,
    required this.farLength,
    required this.title,
    required this.titleStyle,
    this.color = Colors.white,
    this.location = RibbonLocation.topStart,
    this.boxShadow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _RibbonPainter(
        nearLength: nearLength,
        farLength: farLength,
        title: title,
        titleStyle: titleStyle,
        color: color,
        boxShadow: boxShadow,
        location: location,
      ),
      child: child,
    );
  }
}

class _RibbonPainter extends CustomPainter {
  double nearLength;
  double farLength;
  final String title;
  final Color color;
  final BoxShadow? boxShadow;
  final TextStyle titleStyle;
  final RibbonLocation location;
  bool initialized = false;
  late TextPainter textPainter;
  late Paint paintRibbon;
  late Path pathRibbon;
  late double rotateRibbon;
  late Offset offsetRibbon;
  late Offset offsetTitle;
  late Paint? paintShadow;

  _RibbonPainter({
    required this.nearLength,
    required this.farLength,
    required this.title,
    required this.titleStyle,
    required this.color,
    this.boxShadow,
    required this.location,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!initialized) _init(size);

    canvas
      ..drawPath(pathRibbon, paintRibbon)
      ..translate(offsetRibbon.dx, offsetRibbon.dy)
      ..rotate(rotateRibbon);

    textPainter.paint(canvas, offsetTitle);
  }

  @override
  bool shouldRepaint(_RibbonPainter oldDelegate) {
    return title != oldDelegate.title ||
        nearLength != oldDelegate.nearLength ||
        farLength != oldDelegate.farLength ||
        color != oldDelegate.color ||
        location != oldDelegate.location;
  }

  void _init(Size size) {
    initialized = true;

    if (nearLength > farLength) {
      double temp = farLength;
      farLength = nearLength;
      nearLength = temp;
    }

    if (farLength > size.width) farLength = size.width;

    TextSpan span = TextSpan(style: titleStyle, text: title);

    textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout();

    paintRibbon = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    offsetTitle = Offset(-textPainter.width / 2, -textPainter.height / 2);
    rotateRibbon = _rotation;
    pathRibbon = _ribbonPath(size);
    paintShadow = boxShadow?.toPaint();
  }

  Path _ribbonPath(Size size) {
    Path path = Path();
    List<Offset> vec = [];
    if (size.width <= size.height) {
      switch (location) {
        case RibbonLocation.topStart:
          path.moveTo(nearLength, 0);
          vec.add(Offset(nearLength, 0));
          path.lineTo(farLength, 0);
          vec.add(Offset(farLength, 0));
          path.lineTo(0, farLength);
          vec.add(Offset(0, farLength));
          path.lineTo(0, nearLength);
          vec.add(Offset(0, nearLength));
          break;
        case RibbonLocation.topEnd:
          path.moveTo(size.width - nearLength, 0);
          vec.add(Offset(size.width - nearLength, 0));
          path.lineTo(size.width - farLength, 0);
          vec.add(Offset(size.width - farLength, 0));
          path.lineTo(size.width, farLength);
          vec.add(Offset(size.width, farLength));
          path.lineTo(size.width, nearLength);
          vec.add(Offset(size.width, nearLength));
          break;
        case RibbonLocation.bottomStart:
          path.moveTo(0, size.height - nearLength);
          vec.add(Offset(0, size.height - nearLength));
          path.lineTo(0, size.height - farLength);
          vec.add(Offset(0, size.height - farLength));
          path.lineTo(farLength, size.height);
          vec.add(Offset(farLength, size.height));
          path.lineTo(nearLength, size.height);
          vec.add(Offset(nearLength, size.height));
          break;
        case RibbonLocation.bottomEnd:
          path.moveTo(size.width - nearLength, size.height);
          vec.add(Offset(size.width - nearLength, size.height));
          path.lineTo(size.width - farLength, size.height);
          vec.add(Offset(size.width - farLength, size.height));
          path.lineTo(size.width, size.height - farLength);
          vec.add(Offset(size.width, size.height - farLength));
          path.lineTo(size.width, size.height - nearLength);
          vec.add(Offset(size.width, size.height - nearLength));
          break;
      }
    } else {
      switch (location) {
        case RibbonLocation.topStart:
          path.moveTo(nearLength, 0);
          vec.add(Offset(nearLength, 0));
          path.lineTo(farLength, 0);
          vec.add(Offset(farLength, 0));
          if (farLength <= size.height) {
            path.lineTo(0, farLength);
            vec.add(Offset(0, farLength));
            path.lineTo(0, nearLength);
            vec.add(Offset(0, nearLength));
          } else {
            path.lineTo(farLength - size.height, size.height);
            vec.add(Offset(farLength - size.height, size.height));
            if (nearLength <= size.height) {
              path.lineTo(0, size.height);
              vec.add(Offset(0, size.height));
              path.lineTo(0, nearLength);
              vec.add(Offset(0, nearLength));
            } else {
              path.lineTo(nearLength - size.height, size.height);
              vec.add(Offset(nearLength - size.height, size.height));
            }
          }
          break;
        case RibbonLocation.topEnd:
          path.moveTo(size.width - nearLength, 0);
          vec.add(Offset(size.width - nearLength, 0));
          path.lineTo(size.width - farLength, 0);
          vec.add(Offset(size.width - farLength, 0));
          if (farLength <= size.height) {
            path.lineTo(size.width, farLength);
            vec.add(Offset(size.width, farLength));
            path.lineTo(size.width, nearLength);
            vec.add(Offset(size.width, nearLength));
          } else {
            path.lineTo(size.width - (farLength - size.height), size.height);
            vec.add(
                Offset(size.width - (farLength - size.height), size.height));
            if (nearLength <= size.height) {
              path.lineTo(size.width, size.height);
              vec.add(Offset(size.width, size.height));
              path.lineTo(size.width, nearLength);
              vec.add(Offset(size.width, nearLength));
            } else {
              path.lineTo(size.width - (nearLength - size.height), size.height);
              vec.add(
                  Offset(size.width - (nearLength - size.height), size.height));
            }
          }
          break;
        case RibbonLocation.bottomStart:
          path.moveTo(nearLength, size.height);
          vec.add(Offset(nearLength, size.height));
          path.lineTo(farLength, size.height);
          vec.add(Offset(farLength, size.height));
          if (farLength <= size.height) {
            path.lineTo(0, size.height - farLength);
            vec.add(Offset(0, size.height - farLength));
            path.lineTo(0, size.height - nearLength);
            vec.add(Offset(0, size.height - nearLength));
          } else {
            path.lineTo(farLength - size.height, 0);
            vec.add(Offset(farLength - size.height, 0));
            if (nearLength <= size.height) {
              path.lineTo(0, 0);
              vec.add(const Offset(0, 0));
              path.lineTo(0, size.height - nearLength);
              vec.add(Offset(0, size.height - nearLength));
            } else {
              path.lineTo(nearLength - size.height, 0);
              vec.add(Offset(nearLength - size.height, 0));
            }
          }
          break;
        case RibbonLocation.bottomEnd:
          path.moveTo(size.width - nearLength, size.height);
          vec.add(Offset(size.width - nearLength, size.height));
          path.lineTo(size.width - farLength, size.height);
          vec.add(Offset(size.width - farLength, size.height));
          if (farLength <= size.height) {
            path.lineTo(size.width, size.height - farLength);
            vec.add(Offset(size.width, size.height - farLength));
            path.lineTo(size.width, size.height - nearLength);
            vec.add(Offset(size.width, size.height - nearLength));
          } else {
            path.lineTo(size.width - (farLength - size.height), 0);
            vec.add(Offset(size.width - (farLength - size.height), 0));
            if (nearLength <= size.height) {
              path.lineTo(size.width, 0);
              vec.add(Offset(size.width, 0));
              path.lineTo(size.width, size.height - nearLength);
              vec.add(Offset(size.width, size.height - nearLength));
            } else {
              path.lineTo(size.width - (nearLength - size.height), 0);
              vec.add(Offset(size.width - (nearLength - size.height), 0));
            }
          }
          break;
      }
    }

    path.close();
    List<Offset> vec2 = vec.toSet().toList();
    offsetRibbon = _center(vec2);

    return path;
  }

  double get _rotation {
    switch (location) {
      case RibbonLocation.topStart:
        return -math.pi / 4;
      case RibbonLocation.topEnd:
        return math.pi / 4;
      case RibbonLocation.bottomStart:
        return math.pi / 4;
      case RibbonLocation.bottomEnd:
        return -math.pi / 4;
    }
  }

  Offset _center(List<Offset> v) {
    double sumX = 0, sumY = 0, sumS = 0;
    double x1 = v[0].dx;
    double y1 = v[0].dy;
    double x2 = v[1].dx;
    double y2 = v[1].dy;
    double x3, y3;

    for (int i = 2; i < v.length; i++) {
      x3 = v[i].dx;
      y3 = v[i].dy;
      double s = ((x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1)) / 2.0;
      sumX += (x1 + x2 + x3) * s;
      sumY += (y1 + y2 + y3) * s;
      sumS += s;
      x2 = x3;
      y2 = y3;
    }

    double cx = sumX / sumS / 3.0;
    double cy = sumY / sumS / 3.0;

    return Offset(cx, cy);
  }
}
