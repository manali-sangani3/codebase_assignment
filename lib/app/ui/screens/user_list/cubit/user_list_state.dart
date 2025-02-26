part of 'user_list_cubit.dart';

@immutable
sealed class UserListState extends Equatable {}

final class UserListInitial extends UserListState {
  @override
  List<Object?> get props => [];
}

class FetchUsersLoading extends UserListState {
  @override
  List<Object> get props => [];
}

class UsersFound extends UserListState {
  final bool isLastPage;
  final int currentKey;
  final List<UserData> usersData;

  UsersFound(this.usersData, this.isLastPage, this.currentKey);

  @override
  List<Object> get props => [usersData, isLastPage, currentKey];
}

class UsersNotFound extends UserListState {
  final String errorMesssage;

  UsersNotFound({required this.errorMesssage});

  @override
  List<Object> get props => [];
}

class UsersError extends UserListState {
  final String errorMesssage;

  UsersError({required this.errorMesssage});

  @override
  List<Object> get props => [];
}
