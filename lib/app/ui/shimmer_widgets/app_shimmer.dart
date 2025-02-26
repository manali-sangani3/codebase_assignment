import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerWidget extends StatelessWidget {
  final Widget child;

  const AppShimmerWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.2),
        child: child);
  }
}
