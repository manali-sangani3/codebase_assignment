import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_project/app/model/user_entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

import '../../../../model/base_model.dart';
import '../../../../repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit({required this.repository}) : super(UserListInitial());

  final TextEditingController _searchController = TextEditingController();
  final PagingController<int, UserData> pagingController =
      PagingController(firstPageKey: 1);

  TextEditingController get searchController => _searchController;

  // User repository.
  UserRepository repository;

  UsersEntity? usersEntity;

  List<UserData> originalUsers = []; // Full list of users
  List<UserData> filteredUsers = []; // Search results
  bool isLastPage = false;
  int currentKey = 1;

  void getInitialData(BuildContext context) async {}

  /// Fetch all users
  ///
  Future<void> getUsers({int page = 1}) async {
    if (page == 1) {
      originalUsers.clear(); // Clear only on the first page
      filteredUsers.clear();
      pagingController.itemList = []; // Reset pagingController
    }
    try {
      emit(FetchUsersLoading());
      currentKey = page;
      final response = await repository.getUsers(page: page);

      if (response is FailedResponse) {
        emit(UsersError(errorMesssage: response.errorMessage));
      } else if (response is SuccessResponse) {
        UsersEntity? usersEntityResponse = response.data;
        if (usersEntityResponse != null && usersEntityResponse.data != null) {
          if (usersEntityResponse.data!.isNotEmpty) {
            isLastPage = usersEntityResponse.totalPages == page;

            final newUsers = usersEntityResponse.data!;
            originalUsers.addAll(newUsers);
            filteredUsers = List.from(originalUsers); // Keep filtered list in sync

            emit(UsersFound(newUsers, isLastPage, page)); // Send only new users
          } else {
            emit(UsersFound(const [], true, page));
          }
        } else {
          emit(UsersNotFound(errorMesssage: "Users not found"));
        }
      }
    } catch (ex) {
      emit(UsersError(errorMesssage: "Something went wrong"));
    }
  }


  void searchUsers(String query) {
    if (query.isEmpty) {
      // Restore full paginated list
      filteredUsers = List.from(originalUsers);
    } else {
      filteredUsers = originalUsers
          .where((user) =>
              (user.firstName?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (user.lastName?.toLowerCase().contains(query.toLowerCase()) ??
                  false))
          .toList();
    }

    // Update UI without refreshing the whole API call
    pagingController.itemList = List.from(filteredUsers);
    emit(UsersFound(filteredUsers, isLastPage, currentKey));
  }
}
