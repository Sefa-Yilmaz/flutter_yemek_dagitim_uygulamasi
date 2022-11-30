import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/popular_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/recommended_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/card/card_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_icon.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/detay_yazi.dart';
import 'package:get/get.dart';

class OnerilenYemekDetay extends StatelessWidget {
  final int pageId;
  final String page;
  const OnerilenYemekDetay(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<OnerilenUrunDenetleyicisi>().onerilenUrunList[pageId];
    Get.find<PopulerUrunDenetleyicisi>()
        .initUrun(product, Get.find<SepetKontrolu>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                  child: const AppIcon(icon: Icons.clear),
                ),
                //const AppIcon(icon: Icons.shopping_cart_outlined),
                //kactane alındıgını sepette gösteren yer

                GetBuilder<PopulerUrunDenetleyicisi>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCardPage());
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined),
                          Get.find<PopulerUrunDenetleyicisi>().totalItems >= 1
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Boyutlar.radius20),
                    topRight: Radius.circular(Boyutlar.radius20),
                  ),
                ),
                //başlık kısmı
                child: Center(
                  child: BuyukBaslik(
                    text: product.name!,
                    size: Boyutlar.font26,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              //resim kısmı
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //detay yazısı
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Boyutlar.width20, right: Boyutlar.width20),
                child: DetayYazi(text: product.description!),
              )
            ],
          ))
        ],
      ),
      //satın alma kısmı
      bottomNavigationBar: GetBuilder<PopulerUrunDenetleyicisi>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Boyutlar.width20 * 2.5,
                  right: Boyutlar.width20 * 2.5,
                  top: Boyutlar.height10,
                  bottom: Boyutlar.height10,
                ),
                //artırma ve azaltma kısmı
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setMiktar(false);
                      },
                      child: AppIcon(
                        iconSize: Boyutlar.iconSize24,
                        icon: Icons.remove,
                        IconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                    BuyukBaslik(
                      text:
                          '\$ ${product.price!}  X  ${controller.inCartItems}',
                      color: AppColors.mainBlackColor,
                      size: Boyutlar.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setMiktar(true);
                      },
                      child: AppIcon(
                        iconSize: Boyutlar.iconSize24,
                        IconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.add,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                    //favori kısmı
                    Container(
                        padding: EdgeInsets.only(
                          top: Boyutlar.height20,
                          bottom: Boyutlar.height20,
                          left: Boyutlar.width20,
                          right: Boyutlar.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Boyutlar.radius20),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
                    //sepete ekleme kısmı
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Boyutlar.height20,
                            bottom: Boyutlar.height20,
                            left: Boyutlar.width20,
                            right: Boyutlar.width20),
                        child: BuyukBaslik(
                          text: '\$${product.price} | Sepete ekle',
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Boyutlar.radius20),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
