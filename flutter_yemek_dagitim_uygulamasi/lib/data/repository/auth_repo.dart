import 'package:flutter/widgets.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/api/api_istemcisi.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/signup_body_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiIslemcisi apiIslemcisi;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiIslemcisi, required this.sharedPreferences});

  Future<Response> registration(SingUpBody singUpBody) async {
    return await apiIslemcisi.postData(
        AppConstants.REGISTRATION_URI, singUpBody.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? 'None';
  }

  Future<Response> login(String email, String password) async {
    return await apiIslemcisi.postData(
        AppConstants.LOGIN_URI, {'email': email, 'password': password});
  }

  Future<bool> saveUserToken(String token) async {
    apiIslemcisi.token = token;
    apiIslemcisi.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiIslemcisi.token = '';
    apiIslemcisi.updateHeader('');
    return true;
  }
}
