import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/model/user_entity.dart';
import 'package:flutter_base_project/app/ui/custom_widget/app_bar_mixin.dart';
import 'package:flutter_base_project/app/ui/screens/user_detail/cubit/user_detail_cubit.dart';
import 'package:flutter_base_project/config/resources/text_styles.dart';
import 'package:flutter_base_project/utils/extensions.dart';
import 'package:flutter_base_project/utils/ui_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user_data_entity.dart';

class UserDetailView extends StatefulWidget {
  final UserData details;

  const UserDetailView({super.key, required this.details});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> with AppBarMixin {
  @override
  void initState() {
    context.read<UserDetailCubit>().getUserData(widget.details);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetailCubit cubit = context.read<UserDetailCubit>();
    return Scaffold(
      appBar: buildAppBar(title: "", context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            10.verticalSpace, // Profile Image
            UIComponent.cachedNetworkImageWidget(imageUrl: cubit.avatar),
            10.verticalSpace,
            // Name
            Text(
              cubit.name ?? "",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      "Contact Info",
                      style: h14(),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.email_rounded, color: Colors.grey),
                    title: Text(
                      cubit.email ?? '',
                      style: h20().copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("Personal"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
