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
  final List<UserData> usersData;

  UsersFound(this.usersData, this.isLastPage);

  @override
  List<Object> get props => [usersData, isLastPage];
}

class UsersNotFound extends UserListState {
  final String errorMessage;

  UsersNotFound({required this.errorMessage});

  @override
  List<Object> get props => [];
}

class UsersError extends UserListState {
  final String errorMessage;

  UsersError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
