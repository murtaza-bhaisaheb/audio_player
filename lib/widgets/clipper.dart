import 'package:flutter/material.dart';

class BigClipper extends CustomClipper<Path>{
   @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 140  ;
    final double _yScaling = size.height / 137  ;
    path.lineTo(0 * _xScaling,43.75 * _yScaling);
    path.cubicTo(0 * _xScaling,43.75 * _yScaling,0 * _xScaling,10 * _yScaling,0 * _xScaling,10 * _yScaling,);
    path.cubicTo(0 * _xScaling,3.333333333333333 * _yScaling,3.333333333333333 * _xScaling,0 * _yScaling,10 * _xScaling,0 * _yScaling,);
    path.cubicTo(10 * _xScaling,0 * _yScaling,130 * _xScaling,0 * _yScaling,130 * _xScaling,0 * _yScaling,);
    path.cubicTo(136.66666666666666 * _xScaling,0 * _yScaling,140 * _xScaling,3.333333333333333 * _yScaling,140 * _xScaling,10 * _yScaling,);
    path.cubicTo(140 * _xScaling,10 * _yScaling,140 * _xScaling,77.5 * _yScaling,140 * _xScaling,77.5 * _yScaling,);
    path.cubicTo(140 * _xScaling,84.16666666666666 * _yScaling,137.33333333333331 * _xScaling,89.5 * _yScaling,132 * _xScaling,93.5 * _yScaling,);
    path.cubicTo(132 * _xScaling,93.5 * _yScaling,78 * _xScaling,134 * _yScaling,78 * _xScaling,134 * _yScaling,);
    path.cubicTo(72.66666666666666 * _xScaling,138 * _yScaling,67.33333333333333 * _xScaling,138 * _yScaling,62 * _xScaling,134 * _yScaling,);
    path.cubicTo(62 * _xScaling,134 * _yScaling,8 * _xScaling,93.5 * _yScaling,8 * _xScaling,93.5 * _yScaling,);
    path.cubicTo(2.6666666666666665 * _xScaling,89.5 * _yScaling,0 * _xScaling,84.16666666666666 * _yScaling,0 * _xScaling,77.5 * _yScaling,);
    path.cubicTo(0 * _xScaling,77.5 * _yScaling,0 * _xScaling,43.75 * _yScaling,0 * _xScaling,43.75 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    //throw UnimplementedError();
    return true;
  }

}

