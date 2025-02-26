import 'package:get_it/get_it.dart';

import '../../config/network/dio_config.dart';
import '../../config/network/network_constants.dart';
import '../db/database_helper.dart';
import '../db/db_constants.dart';
import '../db/schema/cart.dart';
import '../model/base_model.dart';
import '../model/product_detail_response.dart';
import '../model/user_entity.dart';

abstract class UserRepository {
  /// Fetch all the users
  Future<ResponseBaseModel> getUsers({int page = 1});
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<ResponseBaseModel> getUsers({int page = 1}) async {
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
        return SuccessResponse(data: usersEntityResponse);
      } else {
        return FailedResponse(errorMessage: response.statusMessage ?? "");
      }
    } else {
      return FailedResponse(errorMessage: response.statusMessage ?? "");
    }
  }
}
