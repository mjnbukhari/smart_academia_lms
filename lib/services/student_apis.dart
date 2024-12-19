import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import '../models/student_details_model.dart';
import '../utlis/api_urls.dart';
import '../utlis/constants.dart';

class StudentAPIs {
  static Future<UserDetailsModel> details() async {
    try {
      final id = Constants.userData.id;
      final token = Constants.userData.token;

      final response = await get(
        Uri.parse("${APIUrls.studentDetails}/$id"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode != 200) {
        throw "Failed to Get Student Details Code: ${response.statusCode}";
      }
      final body = jsonDecode(response.body);

      final data = UserDetailsModel.fromJson(body);

      if (data.success != true) {
        throw data.message!;
      }

      Constants.userDetailsData = data;

      return data;
    } on SocketException catch (_) {
      throw "No Internet, Please check your Connection";
    } on TimeoutException catch (_) {
      throw "Taking too long to respond, Please check your Connection";
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateParent({String? email, String? phone, String? address, required int id}) async {
    try {
      final token = Constants.userData.token;

      final response = await put(
        Uri.parse("${APIUrls.updateParent}/$id"),
        headers: {"Authorization": "Bearer $token"},
        body: {
          if (phone != null) "phoneNumber": phone,
          if (address != null) "address": address,
          if (email != null) "email": email,
        },
      );

      if (response.statusCode != 200) {
        log("URL: ${APIUrls.updateParent}/$id");
        log(response.body);
        throw "Failed to Update Parent Details Code: ${response.statusCode}";
      }
      final body = jsonDecode(response.body);

      if (body["success"] != true) {
        throw body["message"]!;
      }
    } on SocketException catch (_) {
      throw "No Internet, Please check your Connection";
    } on TimeoutException catch (_) {
      throw "Taking too long to respond, Please check your Connection";
    } catch (e) {
      rethrow;
    }
  }
}
