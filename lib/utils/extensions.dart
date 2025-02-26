import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/resources/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

extension Space on num {
  Widget get verticalSpace {
    return SizedBox(height: toDouble());
  }

  Widget get horizontalSpace {
    return SizedBox(width: toDouble());
  }
}

extension StringExtension on String? {
  Widget svgBasic() {
    String path = '$this';
    return SvgPicture.asset(
      path,
    );
  }

  Widget get toSvg => svgBasic();
}

extension StringExtensions on String? {
  String? extractAndCapitalizeFirstLetter() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return this![0].toUpperCase();
  }

  String formatPublishedDate(String publishedDate) {
    // Parse the published date string
    DateTime dateTime = DateTime.parse(publishedDate);

    // Calculate the difference in days, months, and years
    DateTime now = DateTime.now();
    int daysDifference = now.difference(dateTime).inDays;
    int monthsDifference =
        now.month - dateTime.month + (12 * (now.year - dateTime.year));
    int years = monthsDifference ~/ 12;
    int remainingMonths = monthsDifference % 12;
    int remainingDays =
        daysDifference - (monthsDifference * 30); // Assuming 30 days per month

    // Format the date in the "Published X years Y months Z days ago" format
    if (years > 0 && remainingMonths > 0 && remainingDays > 0) {
      return 'Published $years year${years > 1 ? 's' : ''} $remainingMonths month${remainingMonths > 1 ? 's' : ''} $remainingDays day${remainingDays > 1 ? 's' : ''} ago';
    } else if (years > 0 && remainingMonths > 0) {
      return 'Published $years year${years > 1 ? 's' : ''} $remainingMonths month${remainingMonths > 1 ? 's' : ''} ago';
    } else if (years > 0 && remainingDays > 0) {
      return 'Published $years year${years > 1 ? 's' : ''} $remainingDays day${remainingDays > 1 ? 's' : ''} ago';
    } else if (years > 0) {
      return 'Published $years year${years > 1 ? 's' : ''} ago';
    } else if (remainingMonths > 0 && remainingDays > 0) {
      return 'Published $remainingMonths month${remainingMonths > 1 ? 's' : ''} $remainingDays day${remainingDays > 1 ? 's' : ''} ago';
    } else if (remainingMonths > 0) {
      return 'Published $remainingMonths month${remainingMonths > 1 ? 's' : ''} ago';
    } else if (remainingMonths == 0 && remainingDays == 0) {
      return 'Published ${getTimeDifference(dateTime)}';
    } else {
      return 'Published $remainingDays day${remainingDays > 1 ? 's' : ''} ago';
    }
  }

  String getTimeDifference(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    }
  }
}

extension ShowHideExtension on Widget {
  Widget show() {
    return Visibility(
      visible: true,
      child: this,
    );
  }

  Widget hide() {
    return Visibility(
      visible: false,
      child: this,
    );
  }
}

extension ConditionalWidgetExtension on Widget {
  Widget showIf(bool condition) {
    return condition ? this : const SizedBox.shrink();
  }

  Widget hideIf(bool condition) {
    return condition ? const SizedBox.shrink() : this;
  }
}

// method for round off and return double value
extension DoubleExtension on double {
  double roundOff() {
    double decimalPart = this - floor();
    if (decimalPart >= 0.5) {
      return ceilToDouble();
    } else {
      return floorToDouble();
    }
  }
}

extension CustomDivider on Divider {
  static Divider colored() {
    return const Divider(
      color: AppColors.greyE9,
    );
  }
}

extension CurrencyFormatter on num {
  String formatCurrency({bool showSymbol = true, String? currencySymbol}) {
    // if (currencySymbol != null && currencySymbol.isEmpty) {
    //   return "0";
    // }
    //
    // if (this < 0) {
    //   return "-";
    // }

    final locale = _getLocaleForCurrencySymbol(currencySymbol);
    final currencyFormat = NumberFormat.currency(
      locale: locale,
      symbol: currencySymbol ?? (showSymbol ? "\$ " : ''),
    );

    // if (this == 0) {
    //   return "-";
    // } else {
    final formattedValue = currencyFormat.format(this);
    if (currencySymbol == "€") {
      return formattedValue.replaceAll(",00", "");
    } else {
      return formattedValue.replaceAll(".00", "");
    }

    // }
  }

  String _getLocaleForCurrencySymbol(String? currencySymbol) {
    switch (currencySymbol) {
      case 'إ.د':
        return 'ar';
      case '€':
        return 'de'; // Change this to appropriate locale
      case '£':
        return 'en_GB';
      case 'ق.ر':
        return 'ar';
      case '﷼':
        return 'ar';
      case '\$':
        return 'en_US';
      default:
        return 'en_US'; // Defaulting to English locale
    }
  }

  String formatCurrencyForSlider(
      {bool showSymbol = true, String? currencySymbol}) {
    if (currencySymbol != null && currencySymbol.isEmpty) {
      return "$this";
    }

    final locale = _getLocaleForCurrencySymbol(currencySymbol);
    final currencyFormat = NumberFormat.currency(
      locale: locale,
      symbol: currencySymbol ?? (showSymbol ? "\$ " : ''),
    );

    final formattedValue = currencyFormat.format(this);
    return formattedValue.endsWith('.00')
        ? formattedValue.split('.').first
        : formattedValue;
  }
}
