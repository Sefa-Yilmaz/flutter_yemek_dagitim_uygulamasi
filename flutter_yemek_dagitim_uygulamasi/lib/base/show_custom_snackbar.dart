import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:get/get.dart';

//erorr kısmı tasarımı
void showCustomSnackBar(String message,
    {bool isError = true, String title = 'Error'}) {
  Get.snackbar(
    title,
    message,
    titleText: BuyukBaslik(
      text: title,
      color: Colors.white,
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,
  );
}
