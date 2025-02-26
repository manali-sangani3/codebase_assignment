import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/app_values.dart';
import 'package:flutter_base_project/utils/ui_components.dart';

mixin AppButtonMixin {
  Widget primaryButton(
      {required BuildContext context,
      required String title,
      required final VoidCallback onClick}) {
    return UIComponent.customInkWellWidget(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(AppValues.size_10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
          child: Center(
              child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).hintColor),
          )),
        ),
      ),
    );
  }

  Widget secondaryButton(
      {required BuildContext context,
        required String title,
        required Function onClick}) {
    return Container(
      margin: const EdgeInsets.all(AppValues.size_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).canvasColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        child: Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight:FontWeight.normal, color: Theme.of(context).hintColor),
            )),
      ),
    );
  }
}
