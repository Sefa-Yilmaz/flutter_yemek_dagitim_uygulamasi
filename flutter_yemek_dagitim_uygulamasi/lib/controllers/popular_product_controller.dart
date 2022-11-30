import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/popular_product_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/cart_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/products_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:get/get.dart';
//ürün girilip girilmedini kotolü ve ürün artırma ve azltma işlemi
class PopulerUrunDenetleyicisi extends GetxController {
  final PopulerUrunDeposu populerUrunDeposu;
  PopulerUrunDenetleyicisi({required this.populerUrunDeposu});
  List<ProductModel> _populerUrunList = [];
  List<ProductModel> get populerUrunList => _populerUrunList;
  late SepetKontrolu _sepet;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopulerUrunList() async {
    Response response = await populerUrunDeposu.getPopulerUrunDeposuList();
    if (response.statusCode == 200) {
      _populerUrunList = [];
      _populerUrunList.addAll(Urun.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

//miktar artırma kısmı
  void setMiktar(bool isIncrement) {
    if (isIncrement) {
      print('artırma ' + _quantity.toString());
      _quantity = checkQuantity(_quantity + 1);
    } else {
      print('azaltma ' + _quantity.toString());
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

//en fazla 20 adet en az 0 adet alma kontrolü
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar('Ürün Adeti', 'Öğe sayısını daha fazla azaltamazsınız!',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar('Ürün Adeti', 'Öğe sayısını daha fazla artıramazsınız!',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

//ürünleri sepete ekleme kısmı
  void initUrun(ProductModel product, SepetKontrolu sepet) {
    _quantity = 0;
    _inCartItems = 0;
    _sepet = sepet;
    var exist = false;
    exist = _sepet.existInCart(product);
    print('var yada yok' + exist.toString());
    if (exist) {
      _inCartItems = _sepet.getQuantity(product);
    }
    print('sepetteki miktar' + _inCartItems.toString());
  }

//sepetteki ürün eklendi kısmı
  void addItem(ProductModel product) {
    _sepet.addItem(product, quantity);
    _quantity = 0;
    _inCartItems = _sepet.getQuantity(product);
    _sepet.items.forEach((key, value) {
      print('kimlik' +
          value.id.toString() +
          'miktar' +
          value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _sepet.totalItems;
  }

  List<SepetModel> get getItems {
    return _sepet.getItems;
  }
}
