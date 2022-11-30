import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/recommended_product_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/products_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OnerilenUrunDenetleyicisi extends GetxController {
  final OnerilenUrunDeposu onerilenUrunDeposu;
  OnerilenUrunDenetleyicisi({required this.onerilenUrunDeposu});
  List<ProductModel> _onerilenUrunList = [];
  List<ProductModel> get onerilenUrunList => _onerilenUrunList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getOnerilenUrunList() async {
    Response response = await onerilenUrunDeposu.getOnerilenUrunList();
    if (response.statusCode == 200) {
      _onerilenUrunList = [];
      _onerilenUrunList.addAll(Urun.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
