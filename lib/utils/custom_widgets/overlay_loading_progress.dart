import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class OverlayLoadingProgress {
  static OverlayEntry? _overlay;

  static start(
      BuildContext context, {
        Color? barrierColor = Colors.black54,
        Widget? widget,
        Color color = Colors.black38,
        bool barrierDismissible = true,
        double? loadingWidth,
      }) async {
    if (_overlay != null) {
      stop();
    }
    _overlay = OverlayEntry(builder: (BuildContext context) {
      return _LoadingWidget(
        color: color,
        barrierColor: barrierColor,
        widget: widget,
        barrierDismissible: barrierDismissible,
        loadingWidth: loadingWidth,
      );
    });
    Overlay.of(context).insert(_overlay!);
  }

  static stop() {
    try {
      if (_overlay == null) return;
      _overlay!.remove();
      _overlay = null;
    } catch (ex) {}
  }
}

class _LoadingWidget extends StatelessWidget {
  final Widget? widget;
  final Color? color;
  final Color? barrierColor;
  final bool barrierDismissible;
  final double? loadingWidth;

  const _LoadingWidget({
    super.key,
    this.widget,
    this.color,
    this.barrierColor,
    required this.barrierDismissible,
    this.loadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: barrierDismissible ? OverlayLoadingProgress.stop : null,
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: barrierColor,
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: widget ??
                SizedBox.square(
                  dimension: loadingWidth,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.colorPrimary,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}