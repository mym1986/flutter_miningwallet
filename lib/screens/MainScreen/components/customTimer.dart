import 'dart:math';
import 'package:flutter/material.dart';

class CustomTimerPainter extends CustomPainter {
  // final strokeCircle = 13.0;
  // double currentProgress;

  CustomTimerPainter({
    required this.animation,
  }) : super(repaint: animation);

  final Animation<double> animation;
 

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 17.0
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

      Paint animationArc = Paint()
      ..strokeWidth = 17.0
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

      

    
    canvas.drawCircle(size.center(Offset.zero),size.width / 2.0, paint);
    double progress = (1.0 - animation.value) *2*pi;
    canvas.drawArc(Offset.zero & size, pi*1.5 , progress, false, animationArc);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
