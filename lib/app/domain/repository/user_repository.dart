import 'package:flutter/cupertino.dart';

import '../../model/base_model.dart';

abstract class UserRepository {
  /// Fetch all the users
  Future<ResponseBaseModel> getUsers({int page = 1, BuildContext context});
}