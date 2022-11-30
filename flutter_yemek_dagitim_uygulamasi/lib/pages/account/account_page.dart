import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/custom_app_bar.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/custom_loader.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/auth_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/location_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/user_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/account_widget.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_icon.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:get/get.dart';

class HesapSayfasi extends StatelessWidget {
  const HesapSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: CustomAppBar(title: 'Profile'),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Boyutlar.height20),
                        child: Column(
                          children: [
                            //profil icon
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              IconColor: Colors.white,
                              iconSize: Boyutlar.height15 * 6,
                              size: Boyutlar.height15 * 10,
                            ),
                            SizedBox(height: Boyutlar.height30),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //isim
                                    HesapWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        IconColor: Colors.white,
                                        iconSize: Boyutlar.height10 * 5 / 2,
                                        size: Boyutlar.height10 * 5,
                                      ),
                                      buyukBaslik: BuyukBaslik(text: userController.userModel.name),
                                    ),
                                    SizedBox(height: Boyutlar.height20),
                                    //telefon
                                    HesapWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        IconColor: Colors.white,
                                        iconSize: Boyutlar.height10 * 5 / 2,
                                        size: Boyutlar.height10 * 5,
                                      ),
                                      buyukBaslik: BuyukBaslik(text: userController.userModel.phone),
                                    ),
                                    SizedBox(height: Boyutlar.height20),
                                    //email
                                    HesapWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        IconColor: Colors.white,
                                        iconSize: Boyutlar.height10 * 5 / 2,
                                        size: Boyutlar.height10 * 5,
                                      ),
                                      buyukBaslik: BuyukBaslik(text: userController.userModel.email),
                                    ),
                                    SizedBox(height: Boyutlar.height20),
                                    //adres
                                    GetBuilder<LocationController>(builder: (locationController) {
                                      if (_userLoggedIn && locationController.addressList.isEmpty) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(RouteHelper.getAddressPage());
                                          },
                                          child: HesapWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              backgroundColor: AppColors.yellowColor,
                                              IconColor: Colors.white,
                                              iconSize: Boyutlar.height10 * 5 / 2,
                                              size: Boyutlar.height10 * 5,
                                            ),
                                            buyukBaslik: BuyukBaslik(text: 'adres'),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(RouteHelper.getAddressPage());
                                          },
                                          child: HesapWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              backgroundColor: AppColors.yellowColor,
                                              IconColor: Colors.white,
                                              iconSize: Boyutlar.height10 * 5 / 2,
                                              size: Boyutlar.height10 * 5,
                                            ),
                                            buyukBaslik: BuyukBaslik(text: 'your address'),
                                          ),
                                        );
                                      }
                                    }),
                                    SizedBox(height: Boyutlar.height20),
                                    //mesaj
                                    HesapWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.redAccent,
                                        IconColor: Colors.white,
                                        iconSize: Boyutlar.height10 * 5 / 2,
                                        size: Boyutlar.height10 * 5,
                                      ),
                                      buyukBaslik: BuyukBaslik(text: 'mesaj'),
                                    ),
                                    SizedBox(height: Boyutlar.height20),
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>().userLoggedIn()) {
                                          Get.find<AuthController>().clearSharedData();
                                          Get.find<SepetKontrolu>().clear();
                                          Get.find<SepetKontrolu>().clearCartHistory();
                                          Get.find<LocationController>().clearAddressList();
                                          Get.offNamed(RouteHelper.getSignInPage());
                                        } else {
                                          Get.offNamed(RouteHelper.getSignInPage());
                                        }
                                      },
                                      child: HesapWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: AppColors.mainColor,
                                          IconColor: Colors.white,
                                          iconSize: Boyutlar.height10 * 5 / 2,
                                          size: Boyutlar.height10 * 5,
                                        ),
                                        buyukBaslik: BuyukBaslik(text: 'Logout'),
                                      ),
                                    ),
                                    SizedBox(height: Boyutlar.height20),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Boyutlar.height20 * 15,
                          margin: EdgeInsets.only(left: Boyutlar.width20, right: Boyutlar.width20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Boyutlar.radius20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/image/signintocontinue.png'),
                            ),
                          ),
                        ),
                        SizedBox(height: Boyutlar.height45),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Boyutlar.height20 * 5,
                            margin: EdgeInsets.only(left: Boyutlar.width20, right: Boyutlar.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Boyutlar.radius20),
                            ),
                            child: Center(
                              child: BuyukBaslik(
                                text: 'Sing in',
                                color: Colors.white,
                                size: Boyutlar.font26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
          },
        ));
  }
}
