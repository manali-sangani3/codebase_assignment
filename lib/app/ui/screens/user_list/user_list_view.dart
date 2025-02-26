import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/model/user_entity.dart';
import 'package:flutter_base_project/app/ui/custom_widget/app_bar_mixin.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/cubit/user_list_cubit.dart';
import 'package:flutter_base_project/config/utils.dart';
import 'package:flutter_base_project/utils/extensions.dart';
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
  void initState() {
    context
        .read<UserListCubit>()
        .pagingController
        .addPageRequestListener((pageKey) {
      context.read<UserListCubit>().getUsers(page: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserListCubit cubit = context.read<UserListCubit>();
    return BlocConsumer<UserListCubit, UserListState>(
      listener: (context, state) {
        if (state is FetchUsersLoading) {
          // OverlayLoadingProgress.start(context);
        }
        if (state is UsersFound) {
          if (state.isLastPage) {
            context
                .read<UserListCubit>()
                .pagingController
                .appendLastPage(state.usersData);
          } else {
            context.read<UserListCubit>().pagingController.appendPage(
                state.usersData,
                state.currentKey + 1 // Load next page correctly
                );
          }
        } else if (state is UsersNotFound) {
          context.read<UserListCubit>().pagingController.appendLastPage([]);
          Utils.showErrorMessage(context: context, message: "Users not found");
        } else if (state is UsersError) {
          // OverlayLoadingProgress.stop;
          context.read<UserListCubit>().pagingController.appendLastPage([]);
          Utils.showErrorMessage(
              context: context, message: "Something went wrong");
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: buildAppBar(title: "Users", context: context),
            body: _buildUserBody(cubit));
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
            child: PagedListView<int, UserData>.separated(
              separatorBuilder: (context, index) {
                return 16.verticalSpace;
              },
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: 16,
                  right: 16),
              pagingController: context.read<UserListCubit>().pagingController,
              shrinkWrap: true,
              builderDelegate: PagedChildBuilderDelegate<UserData>(
                noItemsFoundIndicatorBuilder: (context) {
                  return const NoDataWidget(
                    title: "No data found",
                  );
                },
                itemBuilder: (context, item, index) {
                  return UserSingleTileWidget(
                    user: item,
                    onUserClick: (int id) {
                      UserData data = item;
                      String modelJson = jsonEncode(data.toJson());
                      context
                          .pushNamed(Routes.kUserDetailScreen, pathParameters: {
                        RouteArguments.userData: modelJson,
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );

  /// Build bloc listener widget.
  void buildBlocListener(BuildContext context, UserListState state) {
    if (state is FetchUsersLoading) {
      // OverlayLoadingProgress.start(context);
    }
    if (state is UsersFound) {
      if (state.isLastPage) {
        context
            .read<UserListCubit>()
            .pagingController
            .appendLastPage(state.usersData);
      } else {
        context.read<UserListCubit>().pagingController.appendPage(
            state.usersData, state.currentKey + 1 // Load next page correctly
            );
      }
    } else if (state is UsersNotFound) {
      context.read<UserListCubit>().pagingController.appendLastPage([]);
      Utils.showErrorMessage(context: context, message: "Users not found");
    } else if (state is UsersError) {
      // OverlayLoadingProgress.stop;
      context.read<UserListCubit>().pagingController.appendLastPage([]);
      Utils.showErrorMessage(context: context, message: "Something went wrong");
    }
  }

  @override
  void dispose() {
    (context.read<UserListCubit>().pagingController.itemList ?? []).clear();
    super.dispose();
  }
}
