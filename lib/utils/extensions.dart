import 'package:flutter/material.dart';

extension Space on num {
  Widget get verticalSpace {
    return SizedBox(height: toDouble());
  }

  Widget get horizontalSpace {
    return SizedBox(width: toDouble());
  }
}
