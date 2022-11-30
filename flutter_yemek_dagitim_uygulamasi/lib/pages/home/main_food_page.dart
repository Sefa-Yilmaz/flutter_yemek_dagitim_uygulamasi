import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/popular_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/recommended_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/home/food_page_body.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/kucuk_baslik.dart';
import 'package:get/get.dart';

class AnaYemekSayfasi extends StatefulWidget {
  const AnaYemekSayfasi({super.key});

  @override
  State<AnaYemekSayfasi> createState() => _AnaYemekSayfasiState();
}

class _AnaYemekSayfasiState extends State<AnaYemekSayfasi> {
  Future<void> _loadResource() async {
    await Get.find<PopulerUrunDenetleyicisi>().getPopulerUrunList();
    await Get.find<OnerilenUrunDenetleyicisi>().getOnerilenUrunList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _loadResource,
        child: Column(
          children: [
            //appbar kısmı
            Container(
              margin: EdgeInsets.only(
                  top: Boyutlar.height45, bottom: Boyutlar.height15),
              padding: EdgeInsets.only(
                  left: Boyutlar.width20, right: Boyutlar.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      //konum bilgisi
                      BuyukBaslik(text: 'Türkiye', color: AppColors.mainColor),
                      Row(
                        children: [
                          KucukBaslik(text: 'Ankara', color: Colors.black54),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  //arama buton kısmı
                  Container(
                    width: Boyutlar.height45,
                    height: Boyutlar.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Boyutlar.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Boyutlar.iconSize24,
                    ),
                  )
                ],
              ),
            ),
            //yemek sayfası
            const Expanded(
                child: SingleChildScrollView(
              child: YemekSayfasiBody(),
            ))
          ],
        ));
  }
}
