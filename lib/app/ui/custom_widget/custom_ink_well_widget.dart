import 'package:flutter/material.dart';

class CustomInkWellWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  final double? padding;

  const CustomInkWellWidget({super.key, this.onTap, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: child,
        ));
    ;
  }
}
