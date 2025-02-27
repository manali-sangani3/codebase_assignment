import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../config/network/dio_config.dart';
import '../../../config/network/network_constants.dart';
import '../../domain/repository/user_repository.dart';
import '../../model/base_model.dart';
import '../../model/user_data_entity.dart';
import '../../model/user_entity.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<ResponseBaseModel> getUsers({int page = 1, BuildContext? context}) async {
    final response = await GetIt.I<DioProvider>().getBaseAPI(
      url: NetworkAPIs.kGetUsers,
      queryParams: {
        "per_page": 10,
        "page": page,
      },
    );
    if (response.data != null) {
      if (response.statusCode == 200) {
        UsersEntity usersEntityResponse = UsersEntity.fromJson(response.data);
        final box = Hive.box<List>('usersBox');
        if (page == 1) {
          box.delete('users');
          box.put('users', usersEntityResponse.data!);
        } else {
          final Box hiveDetails = Hive.box<List>('usersBox');
          final data = hiveDetails.get('users');
          box.put('users', data.cast<UserData>() + usersEntityResponse.data!);
        }

        return SuccessResponse(data: usersEntityResponse);
      } else {
        if (response.data != null) {
          final Box hiveDetails = Hive.box<List>('usersBox');
          final data = hiveDetails.get('users');
          if (data != null) {
            return SuccessResponse(
              data: UsersEntity(
                data: data.cast<UserData>(),
              ),
            );
          } else {
            return FailedResponse(errorMessage: response.statusMessage ?? "");
          }
        } else {
          return FailedResponse(errorMessage: response.statusMessage ?? "");
        }
      }
    } else {
      return FailedResponse(errorMessage: response.statusMessage ?? "");
    }
  }
}