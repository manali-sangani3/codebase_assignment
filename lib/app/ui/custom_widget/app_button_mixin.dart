import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/app_colors.dart';
import 'package:flutter_base_project/utils/ui_components.dart';

mixin AppButtonMixin {
  Widget primaryButton(
      {required BuildContext context,
      required String title,
      required final VoidCallback onClick}) {
    return UIComponent.customInkWellWidget(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.colorPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
