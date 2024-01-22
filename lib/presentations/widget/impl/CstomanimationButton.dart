import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAnimation extends StatefulWidget {
  const CustomAnimation({super.key}) ;

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 1500),
)..repeat();
late final Animation<double> _scaleAnimation = Tween<double>(begin: 0.6, end: 1).animate(_controller);
late final Animation<double> _fadeAnimation = Tween<double>(begin: 0.05, end: 0.4).animate(_controller);
  @override
  Widget build(BuildContext context) {
    return Stack(
  alignment: AlignmentDirectional.center,
  children: [
    FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 60 * 1.5,
          height: 60 * 1.5,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        ),
      ),
    ),
    Icon(
      Icons.bolt_outlined,
      size: 50,

    )
  ],
);
  }
  @override
void dispose() {
  _controller.dispose();
  super.dispose();
}
}