import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/model/user_data_entity.dart';
import 'package:flutter_base_project/app/ui/custom_widget/app_bar_mixin.dart';
import 'package:flutter_base_project/app/ui/custom_widget/app_button_mixin.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/cubit/user_list_cubit.dart';
import 'package:flutter_base_project/config/app_colors.dart';
import 'package:flutter_base_project/utils/app_localization.dart';
import 'package:flutter_base_project/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/resources/text_styles.dart';
import '../../../navigation/routes.dart';
import '../../custom_widget/custom_ink_well_widget.dart';
import '../../single_tile_widgets/user_single_tile_widget.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView>
    with AppBarMixin, AppButtonMixin {
  late UserListCubit cubit;

  @override
  void initState() {
    cubit = context.read<UserListCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  const ValueKey('user_list_page'),
      appBar: buildAppBar(
          title: appStrings(context).titleUsers,
          context: context,
          actions: [
            CustomInkWellWidget(
                onTap: () {
                  cubit.refreshUsers();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.refresh),
                ))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: cubit.searchController,
              onChanged: (query) => cubit.searchUsers(query, context),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                  hintText: appStrings(context).searchHint,
                  hintStyle:
                      h16().copyWith(color: AppColors.black.withAlpha(150)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      cubit.searchController.clear();
                      cubit.searchUsers(
                          "", context); // Reset to full list instead of refresh
                    },
                  )),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return cubit.refreshUsers();
                },
                child: BlocBuilder<UserListCubit, UserListState>(
                  builder: (context, state) {
                    // Show loading only for the first load
                    if (state is FetchUsersLoading) {
                      return Container(
                          color: AppColors.white,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    }

                    // Show error message if API fails
                    if (state is UsersError) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Text(state.errorMessage)),
                          primaryButton(
                            context: context,
                            title: appStrings(context).btnRetry,
                            onClick: () {
                              cubit.refreshUsers();
                            },
                          )
                        ],
                      );
                    }

                    // Show "No Data Found" when list is empty (FIXED!)
                    if (cubit.filteredUsers.isEmpty) {
                      return Center(
                        child: Text(
                          appStrings(context).noData,
                          style: h18().copyWith(fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                    return ListView.separated(
                      controller: cubit.scrollController,
                      separatorBuilder: (context, index) => 16.verticalSpace,
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: cubit.filteredUsers.length +
                          (cubit.isLastPage ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index == cubit.filteredUsers.length &&
                            !cubit.isLastPage) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final user = cubit.filteredUsers[index];
                        return UserSingleTileWidget(
                          user: user,
                          onUserClick: (UserData user) {
                            context.pushNamed(Routes.kUserDetailScreen,
                                extra: user);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cubit.scrollController.dispose();
    super.dispose();
  }
}
