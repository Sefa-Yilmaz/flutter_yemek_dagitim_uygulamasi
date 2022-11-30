import 'package:flutter_yemek_dagitim_uygulamasi/data/api/api_istemcisi.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/response_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class UserRepo {
  final ApiIslemcisi apiIslemcisi;
  UserRepo({required this.apiIslemcisi});
  Future<Response> getUserInfo() async {
    return await apiIslemcisi.getData(AppConstants.USER_INFO_URI);
  }
}
