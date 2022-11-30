import 'package:flutter_yemek_dagitim_uygulamasi/controllers/auth_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/location_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/order_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/popular_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/recommended_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/user_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/api/api_istemcisi.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/auth_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/cart_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/location_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/order_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/popular_product_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/recommended_product_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/user_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api işlemcisi
  Get.lazyPut(() => ApiIslemcisi(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiIslemcisi: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiIslemcisi: Get.find()));
  //depolar
  Get.lazyPut(() => PopulerUrunDeposu(apiIslemcisi: Get.find()));
  Get.lazyPut(() => OnerilenUrunDeposu(apiIslemcisi: Get.find()));
  Get.lazyPut(() => SepetDeposu(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiIslemcisi: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiIslemcisi: Get.find()));
  //kontroller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopulerUrunDenetleyicisi(populerUrunDeposu: Get.find()));
  Get.lazyPut(() => OnerilenUrunDenetleyicisi(onerilenUrunDeposu: Get.find()));
  Get.lazyPut(() => SepetKontrolu(sepetDeposu: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
