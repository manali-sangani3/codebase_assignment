import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_project/app/model/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/base_model.dart';
import '../../../../model/user_data_entity.dart';
import '../../../../repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  UserListCubit({required this.repository}) : super(UserListInitial()) {
    scrollController.addListener(scrollListener);
    getUsers();
  }

  TextEditingController get searchController => _searchController;

  // User repository.
  UserRepository repository;

  UsersEntity? usersEntity;

  List<UserData> users = [];
  List<UserData> filteredUsers = [];
  bool isLastPage = false;
  int currentKey = 1;


  void scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoading &&
        !isLastPage) {
      getUsers();
    }
  }

  Future<void> refreshUsers() async {
    page = 1;
    isLastPage = false;
    users.clear();
    filteredUsers.clear();
    emit(UserListInitial());
    await getUsers();
  }

  /// Fetch all users
  ///
  Future<void> getUsers() async {

    if (isLoading || isLastPage) return;
    isLoading = true;
    // Show loader only if no cached data is available
    if (users.isEmpty) {
      emit(FetchUsersLoading());
    }
    try {
      final response = await repository.getUsers(page: page);
      if (response is SuccessResponse) {
        final List<UserData> newUsers = response.data?.data ?? [];
        if (newUsers.isNotEmpty) {
          users.addAll(newUsers);
          filteredUsers = List.from(users);
          isLastPage = page >= (response.data?.totalPages ?? 1);
          page++;
          emit(UsersFound(filteredUsers, isLastPage));
        } else {
          isLastPage = true;
          emit(UsersFound(const [], isLastPage));
        }
      } else {

        emit(UsersError(errorMessage: "Failed to fetch users"));
      }
    } catch (e) {
      emit(UsersError(errorMessage: "Something went wrong"));
    }
    isLoading = false;
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers = List.from(users);
    } else {
      filteredUsers = users
          .where((user) =>
              (user.firstName!.toLowerCase().contains(query.toLowerCase()) ||
                  user.lastName!.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    if (filteredUsers.isEmpty) {
      emit(UsersNotFound(
          errorMesssage: "No users found")); // Emit when search is empty
    } else {
      emit(UsersFound(filteredUsers, isLastPage));
    }
  }
}
