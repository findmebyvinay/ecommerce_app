// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ThreeDotLoader extends StatefulWidget {
  final double? dotSize;
  final double? maxDotSize;
  final Color? dotColor;

  const ThreeDotLoader({
    super.key,
    this.dotSize = 8.0,
    this.maxDotSize = 14.0,
    this.dotColor = Colors.white,
  });

  @override
  _ThreeDotLoaderState createState() => _ThreeDotLoaderState();
}

class _ThreeDotLoaderState extends State<ThreeDotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _opacityAnimations;
  late List<Animation<double>> _sizeAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat();

    _opacityAnimations = List.generate(3, (index) {
      return Tween(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            0.6 + index * 0.2,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });

    _sizeAnimations = List.generate(3, (index) {
      return Tween(begin: widget.dotSize, end: widget.maxDotSize).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            0.6 + index * 0.2,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimations[index].value,
          child: Container(
            width: _sizeAnimations[index].value,
            height: _sizeAnimations[index].value,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: widget.dotColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, _buildDot),
    );
  }
}
