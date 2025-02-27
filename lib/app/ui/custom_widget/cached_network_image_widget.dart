import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final BoxFit? fit;
  double? borderRadius = 100.0;

  CachedNetworkImageWidget(
      {super.key,
      required this.imageUrl,
      this.height,
      this.fit,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 100),
      child: CachedNetworkImage(
        height: height,
        fit: fit,
        imageUrl: imageUrl,
        placeholder: (context, url) => Image.asset(
          AppAssets.placeholder,
          fit: BoxFit.cover,
        ),
      ),
    );
    ;
  }
}
