import 'package:auth_todo/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({super.username, super.token, super.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String?,
      token: json['token'] as String?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'token': token, 'id': id};
  }
}
