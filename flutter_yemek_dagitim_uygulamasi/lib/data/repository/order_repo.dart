import 'package:flutter_yemek_dagitim_uygulamasi/data/api/api_istemcisi.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/place_order_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiIslemcisi apiIslemcisi;
  OrderRepo({required this.apiIslemcisi});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiIslemcisi.postData(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiIslemcisi.getData(AppConstants.ORDER_LIST_URI);
  }
}
