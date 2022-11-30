import 'package:flutter_yemek_dagitim_uygulamasi/data/api/api_istemcisi.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:get/get.dart';

//populer ürünleri getirme kısmı(interneten)
class PopulerUrunDeposu extends GetxService {
  final ApiIslemcisi apiIslemcisi;
  PopulerUrunDeposu({required this.apiIslemcisi});

  Future<Response> getPopulerUrunDeposuList() async {
    //  return await apiIslemcisi.getData(AppConstants.DRINKS_URI);
    return await apiIslemcisi.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
