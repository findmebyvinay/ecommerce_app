import 'dart:ui';

import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassWidget extends StatelessWidget {
  final Widget child;
  const GlassWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 1.sw,
      height: 1.sh,
      color: Colors.transparent,
      child: Stack(
        children: [
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: context.isDark
                  ? Colors.black.withAlpha(10)
                  : Colors.white.withAlpha(10), // glass tint
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Loader on top of blur
          Center(child: child),
        ],
      ),
    );
  }
}
