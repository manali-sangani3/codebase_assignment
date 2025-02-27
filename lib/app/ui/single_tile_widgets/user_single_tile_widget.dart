import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/resources/text_styles.dart';
import 'package:flutter_base_project/utils/ui_components.dart';

import '../../model/user_data_entity.dart';

class UserSingleTileWidget extends StatelessWidget {
  final UserData user;
  Function(int id) onUserClick;

  UserSingleTileWidget(
      {required this.user, required this.onUserClick, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(12),
      onTap: () {
        onUserClick(user.id ?? -1);
      },
      leading: Container(
        constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
        child: UIComponent.cachedNetworkImageWidget(
          imageUrl: user.avatar ?? "",
        ),
      ),
      title: Text(
        "${user.firstName} ${user.lastName}" ?? "-",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: h16(),
      ),
    );
  }
}
