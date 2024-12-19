
import '../utlis/api_urls.dart';

class UserModel {
  bool? success;
  int? id;
  String? name;
  String? role;
  String? avatar;
  String? email;
  String? token;
  String? message;

  UserModel({
    this.success,
    this.id,
    this.name,
    this.role,
    this.avatar,
    this.email,
    this.token,
    this.message,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    id = json['id'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'] != null ? "${APIUrls.baseUrl}/${json['avatar']}" : null;
    email = json['email'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['avatar'] = avatar;
    data['email'] = email;
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}
