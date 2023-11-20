import 'package:flutter/material.dart';

/// A custom widget representing a landing box used for content presentation.
class LandingBox extends StatelessWidget {
  /// The width of the screen where the [LandingBox] is displayed.
  final double screenWidth;

  /// The height of the screen where the [LandingBox] is displayed.
  final double screenHeight;


  /// The child widget to be displayed inside the [LandingBox].
  final Widget child;

  /// Creates a [LandingBox] widget.
  const LandingBox({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: IntrinsicHeight(
            child: child,
          ),
        ),
      ),
    );
  }
}
