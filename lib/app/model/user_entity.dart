import 'package:flutter_base_project/app/model/user_data_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UsersEntity extends HiveObject {
  @HiveField(0)
  int? page;
  @HiveField(1)
  int? perPage;
  @HiveField(2)
  int? total;
  @HiveField(3)
  int? totalPages;
  @HiveField(4)
  List<UserData>? data;

  UsersEntity({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  UsersEntity.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
