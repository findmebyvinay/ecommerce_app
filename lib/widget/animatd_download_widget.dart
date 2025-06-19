import 'package:flutter/material.dart';

class AnimatedDownloadIcon extends StatefulWidget {
  final double size;
  final Color color;

  const AnimatedDownloadIcon({
    super.key,
    this.size = 48.0,
    this.color = Colors.blue,
  });

  @override
  State<AnimatedDownloadIcon> createState() => _AnimatedDownloadIconState();
}

class _AnimatedDownloadIconState extends State<AnimatedDownloadIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Icon(
        Icons.download_rounded,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}
