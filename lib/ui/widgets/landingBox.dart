import 'package:flutter/material.dart';

class LandingBox extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isWideScreen;
  final Widget child;
  const LandingBox(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.isWideScreen,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: isWideScreen
            ? BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    1.0,
                    2.5,
                  ), //Offset
                  blurRadius: 5.0,
                  spreadRadius: 0.1,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ])
            : null,
        child: SizedBox(
          width: isWideScreen ? screenWidth * 0.3 : screenWidth * 0.9,
          height: isWideScreen ? screenHeight * 0.55 : null,
          child: child,
        ),
      ),
    );
  }
}
