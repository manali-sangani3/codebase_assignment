import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/ui/custom_widget/app_bar_mixin.dart';
import 'package:flutter_base_project/config/resources/text_styles.dart';
import 'package:flutter_base_project/utils/app_localization.dart';
import 'package:flutter_base_project/utils/extensions.dart';

import '../../../model/user_data_entity.dart';
import '../../custom_widget/cached_network_image_widget.dart';

class UserDetailView extends StatefulWidget {
  final UserData details;

  const UserDetailView({super.key, required this.details});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> with AppBarMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "", context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.verticalSpace, // Profile Image
              CachedNetworkImageWidget(imageUrl: widget.details.avatar ?? ''),
              10.verticalSpace,
              // Name
              Text(
                "${(widget.details.firstName ?? "").trim()} ${(widget.details.lastName ?? "").trim()}"
                    .trim(),
                style: h22().copyWith(fontWeight: FontWeight.bold),
              ),
              40.verticalSpace,

              // Email
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        appStrings(context).lblContactInfo,
                        style: h14(),
                      ),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.email_rounded, color: Colors.grey),
                      title: Text(
                        widget.details.email ?? '',
                        style: h20().copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(appStrings(context).lblPersonal),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
