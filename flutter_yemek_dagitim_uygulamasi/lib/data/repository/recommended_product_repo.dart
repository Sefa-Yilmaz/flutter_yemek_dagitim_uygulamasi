import 'package:flutter_yemek_dagitim_uygulamasi/data/api/api_istemcisi.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

//önerilen ürünleri getirme kısmı(interneten)
class OnerilenUrunDeposu extends GetxService {
  final ApiIslemcisi apiIslemcisi;
  OnerilenUrunDeposu({required this.apiIslemcisi});

  Future<Response> getOnerilenUrunList() async {
    return await apiIslemcisi.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
