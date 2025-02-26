import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/model/user_entity.dart';
import 'package:flutter_base_project/app/ui/custom_widget/app_bar_mixin.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/cubit/user_list_cubit.dart';
import 'package:flutter_base_project/config/utils.dart';
import 'package:flutter_base_project/utils/extensions.dart';
import 'package:flutter_base_project/utils/ui_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../config/resources/text_styles.dart';
import '../../../../utils/custom_widgets/overlay_loading_progress.dart';
import '../../../navigation/route_arguments.dart';
import '../../../navigation/routes.dart';
import '../../no_data_widget.dart';
import '../../single_tile_widgets/product_single_tile_widget.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> with AppBarMixin {
  @override
  Widget build(BuildContext context) {
    UserListCubit cubit = context.read<UserListCubit>();
    return BlocConsumer<UserListCubit, UserListState>(
      listener: buildBlocListener,
      builder: (context, state) {
        return Scaffold(
            appBar: buildAppBar(title: "Users", context: context, actions: [
              UIComponent.customInkWellWidget(
                  onTap: () {
                    cubit.refreshUsers();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(Icons.refresh),
                  ))
            ]),
            body: RefreshIndicator(
                onRefresh: () {
                  return cubit.refreshUsers();
                },
                child: _buildUserBody(cubit)));
      },
    );
  }

  /// Build product body widget.
  Widget _buildUserBody(UserListCubit cubit) => Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: cubit.searchController,
              onChanged: (query) => cubit.searchUsers(query),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "Search by first or last name...",
                hintStyle: h16().copyWith(color: Colors.black.withAlpha(150)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: cubit.searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          cubit.searchController.clear();
                          cubit.searchUsers(
                              ""); // Reset to full list instead of refresh
                        },
                      )
                    : null,
              ),
            ),
          ),

          // User List
          Expanded(
            child: cubit.filteredUsers.isNotEmpty
                ? ListView.separated(
                    controller: cubit.scrollController,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount:
                        cubit.filteredUsers.length + (cubit.isLastPage ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == cubit.filteredUsers.length &&
                          !cubit.isLastPage) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final user = cubit.filteredUsers[index];
                      return UserSingleTileWidget(
                        user: user,
                        onUserClick: (int id) {
                          String modelJson = jsonEncode(user.toJson());
                          context.pushNamed(Routes.kUserDetailScreen,
                              pathParameters: {
                                RouteArguments.userData: modelJson,
                              });
                        },
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "No data found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
          ),
        ],
      );

  // Build bloc listener widget.
  void buildBlocListener(BuildContext context, UserListState state) {
    final cubit = context.read<UserListCubit>();

    // Show loading only for the first load
    if (state is FetchUsersLoading) {
      const Center(child: CircularProgressIndicator());
    }

    // Show error message if API fails
    if (state is UsersError) {
      Center(child: Text(state.errorMessage));
    }

    // Show "No Data Found" when list is empty (FIXED!)
    if (cubit.filteredUsers.isEmpty) {
      const Center(
        child: Text(
          "No data found",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    }
  }

  @override
  void dispose() {
    context.read<UserListCubit>().scrollController.dispose();
    super.dispose();
  }
}
