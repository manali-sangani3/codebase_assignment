import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/app_values.dart';

import 'app_shimmer.dart';

class ProductLoadingShimmerWidget extends StatelessWidget {
  final int prodctsCount;

  const ProductLoadingShimmerWidget({required this.prodctsCount, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const Key("procutsShimmer"),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prodctsCount,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: AppValues.size_20),
      itemBuilder: (ctx, index) => AppShimmerWidget(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: Colors.black.withOpacity(0.4),
        ),
      )),
    );
  }
}
