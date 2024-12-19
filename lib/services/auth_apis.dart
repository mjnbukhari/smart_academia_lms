import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../models/user_model.dart';
import '../utlis/api_urls.dart';
import '../utlis/constants.dart';

class AuthAPI {
  //This is the logIn Api
  static Future<UserModel> studentLogIn({
    required String email,
    required String password,
  }) async {
    try {
      final responseLogIn = await post(
        Uri.parse(APIUrls.studentLogin),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (responseLogIn.statusCode != 200) {
        throw "Failed to Login Status Code: ${responseLogIn.statusCode}";
      }
      final body = jsonDecode(responseLogIn.body);

      final userData = UserModel.fromJson(body);

      if (userData.success != true) {
        throw userData.message!;
      }

      Constants.userData = userData;

      return userData;
    } on SocketException catch (_) {
      throw "No Internet, Please check your Connection";
    } on TimeoutException catch (_) {
      throw "Taking too long to respond, Please check your Connection";
    } catch (e) {
      rethrow;
    }
  }
}