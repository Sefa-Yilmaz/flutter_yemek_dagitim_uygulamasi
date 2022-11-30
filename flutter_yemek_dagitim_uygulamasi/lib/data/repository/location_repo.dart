import 'package:flutter_yemek_dagitim_uygulamasi/data/api/api_istemcisi.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/address_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/response_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiIslemcisi apiIslemcisi;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiIslemcisi, required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latlng) async {
    return await apiIslemcisi.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latlng.latitude}&lng${latlng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiIslemcisi.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiIslemcisi.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) async {
    apiIslemcisi.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiIslemcisi.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiIslemcisi.getData('${AppConstants.SEARCH_LOCATTION_URI}?search_text=$text');
  }

  Future<Response> setLocation(String placeID) async {
    return await apiIslemcisi.getData('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeID');
  }
}
