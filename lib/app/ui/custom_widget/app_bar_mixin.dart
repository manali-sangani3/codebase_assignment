import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/app_colors.dart';
import 'package:flutter_base_project/config/resources/text_styles.dart';
import 'package:go_router/go_router.dart';

mixin AppBarMixin {
  PreferredSizeWidget buildAppBar(
      {required String title,
      required BuildContext context,
      bool requireTransparent = false,
      List<Widget>? actions}) {
    return AppBar(
      key: ValueKey('appbar'),
      leading: context.canPop()
          ? InkWell(
              onTap: () {
                context.pop();
              },
              child: const Icon(
                Icons.arrow_back,
              ),
            )
          : null,
      elevation: 0.1,
      backgroundColor: requireTransparent
          ? Colors.transparent
          : AppColors.white,
      title: Text(title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: h22().copyWith(fontWeight: FontWeight.w600)),
      actions: actions,
    );
  }
}
