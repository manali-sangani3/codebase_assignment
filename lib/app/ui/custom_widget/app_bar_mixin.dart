import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin AppBarMixin {
  PreferredSizeWidget buildAppBar(
      {required String title,
      required BuildContext context,
      bool requireTransparent = false,
      List<Widget>? actions}) {
    return AppBar(
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
          : Theme.of(context).appBarTheme.backgroundColor,
      title: Text(title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleLarge
             ),
      actions: actions,
    );
  }
}
