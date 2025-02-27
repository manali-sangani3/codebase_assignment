import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/app_assets.dart';

class UIComponent {
  static Widget customInkWellWidget({
    VoidCallback? onTap,
    Widget? child,
    double? padding,
  }) {
    return InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: child,
        ));
  }

  static cachedNetworkImageWidget(
      {required String? imageUrl,
      double? height,
      BoxFit? fit,
      double borderRadius = 100.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        height: height,
        fit: fit,
        imageUrl: imageUrl ?? "",
        placeholder: (context, url) => Image.asset(
          AppAssets.placeholder,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
