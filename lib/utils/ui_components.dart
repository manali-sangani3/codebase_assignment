import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../config/app_assets.dart';
import '../config/app_colors.dart';
import '../config/app_values.dart';
import '../config/resources/text_styles.dart';

class UIComponent {
  static showCustomBottomSheet({BuildContext? context, Widget? builder}) {
    showModalBottomSheet(
      context: context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: builder!,
        );
      },
    );
  }

  static dataLoader() {
    return GestureDetector(
      // onTap: OverlayLoadingProgress.stop,
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: GestureDetector(
          onTap: () {},
          child: const Center(
            child: SizedBox.square(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.colorPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static dataProgressLoader() {
    return const Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // GestureDetector(
        //   onTap: OverlayLoadingProgress.stop,
        //   child: const SizedBox.square(
        //     child: CircularProgressIndicator(
        //       strokeWidth: 3,
        //       color: AppColors.colorPrimary,
        //     ),
        //   ),
        // ),
      ],
    ));
  }

  static noData() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SVGAssets.noData.toSvg,
            8.verticalSpace,
            Text(
              "No Data",
              textAlign: TextAlign.center,
              style: h12().copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }

  static noChatFound({required String userName}) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Send Message to $userName",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: h18().copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.black),
              ),
            ),
            20.verticalSpace,
            SVGAssets.noData.toSvg,
            20.verticalSpace,
            Text(
              "Start you chat by sending first message!",
              textAlign: TextAlign.center,
              style: h12().copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }

  static noDataRoundedCard() {
    return Container(
      width: double.infinity,
      height: AppValues.screenHeight / 5,
      decoration: BoxDecoration(
          color: AppColors.pageBackground,
          border: Border.all(color: AppColors.greyE9, width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SVGAssets.noData.toSvg,
              8.verticalSpace,
              Text(
                "No Data",
                textAlign: TextAlign.center,
                style: h12().copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static customStatusChip({
    required String statusTitle,
    required Color chipColor,
    required double borderRadius,
    Color? borderColor = Colors.transparent,
    double? horizontalPadding = 16.0,
    required TextStyle textStyle,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? Colors.transparent),
        color: chipColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 6.0, horizontal: horizontalPadding ?? 16.0),
        child: Text(
          statusTitle,
          maxLines: 1,
          style: textStyle,
        ),
      ),
    );
  }

  static socialMediaLoginButton(
      {required String text,
      required Widget icon,
      required Color textColor,
      required Color borderColor,
      required VoidCallback onTap}) {
    return UIComponent.customInkWellWidget(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(44),
            border: Border.all(color: borderColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              6.horizontalSpace,
              Text(
                text,
                style: h14().copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  static Widget createDivider({
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    double height = 2,
    Color color = AppColors.greyE9,
  }) {
    return Padding(
      padding: padding,
      child: Divider(
        height: height,
        color: color,
      ),
    );
  }

  static buildDropdownFormField<T>({
    required List<DropdownMenuItem<T>> items,
    required T? value,
    required void Function(T?) onChanged,
    required String labelText,
    InputDecoration? decoration,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: h14().copyWith(fontWeight: FontWeight.w500),
        ),
        5.verticalSpace,
        DropdownButtonFormField<T>(
          icon: SVGAssets.arrowDownIcon.toSvg,
          items: items,
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.greyE9, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.greyE9, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.greyE9, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: AppColors.errorColor, width: 2),
            ),
          ),
        ),
      ],
    );
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

  static Future<String> chooseDate(
      BuildContext context,
      String helpText,
      TextEditingController textController,
      String datFormat,
      DateTime selectedDate,
      {DateTime? firstDate,
      DateTime? lastDate}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1990),
      lastDate: lastDate ?? DateTime(2100),
      helpText: helpText,
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      textController.text =
          DateFormat(datFormat).format(selectedDate).toString();
    }

    return textController.text.toString();
  }

  static bool isSelectableDay(DateTime day, DateTime initialDate) {
    return !initialDate.isAtSameMomentAs(day);
  }

  static Future<String> chooseDateRange(
      BuildContext context,
      String helpText,
      TextEditingController textController,
      String datFormat,
      DateTime startDate,
      DateTime endDate,
      {DateTime? firstDate,
      String? selectedDateRange,
      DateTime? lastDate}) async {
    DateTimeRange? pickedDate = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1990),
      lastDate: lastDate ?? DateTime(2100),
      helpText: helpText,
    );
    if (pickedDate != null && pickedDate.toString() != selectedDateRange) {
      startDate = pickedDate.start;
      endDate = pickedDate.end;
      String formatStartDate =
          DateFormat(datFormat).format(startDate).toString();
      String formatEndDate = DateFormat(datFormat).format(endDate).toString();
      selectedDateRange = "$formatStartDate - $formatEndDate";
      textController.text = selectedDateRange;
    }
    return textController.text.toString();
  }

  static String formatDate(String date, String dateFormat) {
    var newDate = "";
    final DateFormat formatter = DateFormat(dateFormat);
    newDate = formatter.format(DateTime.parse(date).toLocal());
    return newDate;
  }

  static String convertDateFormat(String date) {
    // Parse the original date string
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    DateTime parsedDate = originalFormat.parse(date);

    // Format the parsed date to the new format
    DateFormat newFormat = DateFormat('yyyy-MM-dd');
    return newFormat.format(parsedDate);
  }

  static String formatTimestamp(int timestamp, String dateFormat) {
    // Convert Unix timestamp (milliseconds) to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format DateTime to "dd/MM/yyyy, HH:mm" format
    String formattedDateTime = DateFormat(dateFormat).format(dateTime);

    return formattedDateTime;
  }

  static num calculateTotalMilestonePrice({num? hours, num? hourlyPrice}) {
    if (hours != null && hourlyPrice != null) {
      // Multiply the hours and hourlyPrice
      num totalPrice = hours * hourlyPrice;

      // Convert the total price to a string
      return totalPrice;
    } else {
      // If either hours or hourlyPrice is null, return an empty string
      return 0;
    }
  }

  static Widget circleProfile(
      {final double? radius = 60,
      final String? imageUrl,
      final Widget? child}) {
    return Container(
      width: radius! * 2, // Diameter
      height: radius * 2, // Diameter
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      // backgroundColor: Colors.transparent,
      child: child,
    );
  }

  static Widget customTextChip(
      {required String? chipLabel, required bool isForDetails}) {
    return Container(
      padding: isForDetails
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          : const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.purpleC4,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        chipLabel ?? "",
        style: h12().copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  static customColoredContainer({required String title}) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyE9, width: 2),
            color: AppColors.purpleC4,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
          child: Text(
            title,
            style: h14().copyWith(fontWeight: FontWeight.w500),
          ),
        ));
  }

  static settingItem({required VoidCallback onTap, required String title}) {
    return UIComponent.customInkWellWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16),
        child: Text(
          title,
          style: h14().copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class TopRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 20); // Adjust the height of top rounded corners
    path.quadraticBezierTo(0, 0, 20, 0); // Adjust radius of top left corner
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(
        size.width, 0, size.width, 20); // Adjust radius of top right corner
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
