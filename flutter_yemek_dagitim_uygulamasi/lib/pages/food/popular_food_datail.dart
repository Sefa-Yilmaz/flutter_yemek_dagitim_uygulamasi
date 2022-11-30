import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/popular_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/card/card_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/home/main_food_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_column.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_icon.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/detay_yazi.dart';
import 'package:get/get.dart';

class PopulerYemekDetay extends StatelessWidget {
  final int pageId;
  final String page;
  const PopulerYemekDetay(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopulerUrunDenetleyicisi>().populerUrunList[pageId];
    Get.find<PopulerUrunDenetleyicisi>()
        .initUrun(product, Get.find<SepetKontrolu>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //araka plan resmi
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Boyutlar.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!,
                  ),
                ),
              ),
            ),
          ),
          //iconlar
          Positioned(
            left: Boyutlar.width20,
            right: Boyutlar.width20,
            top: Boyutlar.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == 'sepetSayfasi') {
                      Get.toNamed(RouteHelper.getCardPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                //satınalma sepetin ustundeki sayı kısmı
                GetBuilder<PopulerUrunDenetleyicisi>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        print('buraya dokunuldu');
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCardPage());
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? const Positioned(
                                  right: 2,
                                  top: 0,
                                  child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      IconColor: Colors.transparent),
                                )
                              : Container(),
                          Get.find<PopulerUrunDenetleyicisi>().totalItems >= 1
                              ? Positioned(
                                  right: 6,
                                  top: 3,
                                  child: BuyukBaslik(
                                    text: Get.find<PopulerUrunDenetleyicisi>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.black,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          //detay sayfası kısmı
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Boyutlar.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                  left: Boyutlar.width20,
                  right: Boyutlar.width20,
                  top: Boyutlar.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Boyutlar.radius20),
                  topRight: Radius.circular(Boyutlar.radius20),
                ),
                color: Colors.white,
              ),
              //detay sayfasındaki başlık yol dk gibi yazıların tasarımı
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Boyutlar.height20),
                  //urun ile ilgili detaylı yazı
                  BuyukBaslik(text: 'Takdim etmek'),
                  SizedBox(height: Boyutlar.height20),
                  Expanded(
                    child: SingleChildScrollView(
                      //urun ile ilgili detaylı yazı
                      child: DetayYazi(text: product.description!),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      //satın alam kısmı
      bottomNavigationBar: GetBuilder<PopulerUrunDenetleyicisi>(
        builder: (populerUrun) {
          return Container(
            //satın alam kısmın boyutlandırma
            height: Boyutlar.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Boyutlar.height30,
              bottom: Boyutlar.height30,
              right: Boyutlar.width20,
              left: Boyutlar.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Boyutlar.radius20 * 2),
                  topRight: Radius.circular(Boyutlar.radius20 * 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //kactane satın alınacak kısmın ici
                Container(
                  padding: EdgeInsets.only(
                    top: Boyutlar.height20,
                    bottom: Boyutlar.height20,
                    left: Boyutlar.width20,
                    right: Boyutlar.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Boyutlar.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            populerUrun.setMiktar(false);
                          },
                          child: const Icon(Icons.remove,
                              color: AppColors.signColor)),
                      SizedBox(width: Boyutlar.width10 / 2),
                      BuyukBaslik(text: populerUrun.inCartItems.toString()),
                      SizedBox(width: Boyutlar.width10 / 2),
                      GestureDetector(
                          onTap: () {
                            populerUrun.setMiktar(true);
                          },
                          child: const Icon(Icons.add,
                              color: AppColors.signColor)),
                    ],
                  ),
                ),
                //sepete ekleme kısmı
                GestureDetector(
                  onTap: () {
                    populerUrun.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Boyutlar.height20,
                        bottom: Boyutlar.height20,
                        left: Boyutlar.width20,
                        right: Boyutlar.width20),
                    child: BuyukBaslik(
                      text: '\$ ${product.price!} ' + '| Sepete ekle',
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Boyutlar.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
