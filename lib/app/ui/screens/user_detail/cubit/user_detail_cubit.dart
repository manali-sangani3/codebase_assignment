import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../model/user_data_entity.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit() : super(UserDetailInitial());

  String? name;
  String? avatar;
  String? email;

  void getUserData(UserData data) {
    name = "${data.firstName} ${data.lastName}";
    avatar = data.avatar;
    email = data.email;
  }
}
