import 'package:flutter/material.dart';

/// A custom widget representing a landing box used for content presentation.
class LandingBox extends StatelessWidget {
  /// The width of the screen where the [LandingBox] is displayed.
  final double screenWidth;

  /// The height of the screen where the [LandingBox] is displayed.
  final double screenHeight;

  /// A flag indicating if the screen is considered wide or not.
  final bool isWideScreen;

  /// The child widget to be displayed inside the [LandingBox].
  final Widget child;

  /// Creates a [LandingBox] widget.
  const LandingBox({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.isWideScreen,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
        decoration: isWideScreen
            ? BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 2.5), //Offset
                    blurRadius: 5.0,
                    spreadRadius: 0.1,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              )
            : null,
        child: SizedBox(
          width: isWideScreen ? screenWidth * 0.3 : screenWidth * 0.9,
          //height: isWideScreen ? screenHeight * 0.55 : null,
          child: IntrinsicHeight(
            child: child,
          ),
        ),
      ),
    );
  }
}
