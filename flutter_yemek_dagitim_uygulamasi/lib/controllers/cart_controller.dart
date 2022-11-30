import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/data/repository/cart_repo.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/cart_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/products_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:get/get.dart';

//sepete eklenen ürünnleri artıtma azaltma işlemi yapılıyor
class SepetKontrolu extends GetxController {
  final SepetDeposu sepetDeposu;
  SepetKontrolu({required this.sepetDeposu});

  Map<int, SepetModel> _items = {};

  Map<int, SepetModel> get items => _items;
  List<SepetModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return SepetModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        //print('öğenin uzunluğu' + _items.length.toString());
        _items.putIfAbsent(product.id!, () {
          /*    print('sepete ürün ekleme id ' +
            product.id!.toString() +
            ' quantity ' +
            quantity.toString());
        _items.forEach((key, value) {
          print('quantity is' + value.quantity.toString());
        }); */
          return SepetModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar('Ürün Adeti', 'En azından sepete bir ürün eklemelisiniz!', backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    sepetDeposu.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

//girilen ürünleri toplama
  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

//sepeteki ürünleri listelems işlemi
  List<SepetModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<SepetModel> getCartData() {
    setCart = sepetDeposu.getCartList();
    return storageItems;
  }

  set setCart(List<SepetModel> items) {
    storageItems = items;
    // print('sepet öğelerinin uzunluğu ' + storageItems.length.toString());
    for (var i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    sepetDeposu.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<SepetModel> getCartHistoryList() {
    return sepetDeposu.getCartHistoryList();
  }

  set setItems(Map<int, SepetModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    sepetDeposu.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    sepetDeposu.clearCartHistory();
    update();
  }

  void removeCardSharedPreference() {
    sepetDeposu.removeCardSharedPreference();
  }
}
