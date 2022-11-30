import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/common_text_button.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/no_data_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/show_custom_snackbar.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/auth_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/location_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/order_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/popular_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/recommended_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/user_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/place_order_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/home/main_food_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/order/delivery_options.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/styles.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_icon.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_text_field.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/kucuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/order/payment_option_button.dart';
import 'package:get/get.dart';

class SepetSayfasi extends StatelessWidget {
  const SepetSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
        body: Stack(
          children: [
            //icon kısmı
            Positioned(
              top: Boyutlar.width20 * 3,
              left: Boyutlar.width20,
              right: Boyutlar.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //geri gitme kısmı
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    IconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Boyutlar.iconSize24,
                  ),
                  SizedBox(width: Boyutlar.width20 * 5),
                  //yemek ana sayfasına gitme
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      IconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Boyutlar.iconSize24,
                    ),
                  ),
                  //sepet kısmı
                  AppIcon(
                    icon: Icons.shopping_cart,
                    IconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Boyutlar.iconSize24,
                  )
                ],
              ),
            ),
            //serpete eklenen ürünleri listeleme kısmı
            GetBuilder<SepetKontrolu>(builder: (_sepetKontrolu) {
              return _sepetKontrolu.getItems.length > 0
                  ? Positioned(
                      top: Boyutlar.height20 * 5,
                      left: Boyutlar.width20,
                      right: Boyutlar.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Boyutlar.height15),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<SepetKontrolu>(
                            builder: (sepetKontrolu) {
                              var _cartList = sepetKontrolu.getItems;
                              return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    height: Boyutlar.height20 * 5,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        //resime tıklandında ayrıntı ve satın alma kısmıne gider
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex =
                                                Get.find<PopulerUrunDenetleyicisi>().populerUrunList.indexOf(_cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(RouteHelper.getPopularFood(popularIndex, 'sepetSayfasi'));
                                            } else {
                                              var recommendedIndex =
                                                  Get.find<OnerilenUrunDenetleyicisi>().onerilenUrunList.indexOf(_cartList[index].product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar('Geçmiş ürün', 'Geçmiş ürünler için ürün incelemesi mevcut değil!',
                                                    backgroundColor: AppColors.mainColor, colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, 'sepetSayfasi'));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Boyutlar.height20 * 5,
                                            height: Boyutlar.height20 * 5,
                                            margin: EdgeInsets.only(bottom: Boyutlar.height10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL + AppConstants.UPLOAD_URL + sepetKontrolu.getItems[index].img!),
                                              ),
                                              borderRadius: BorderRadius.circular(Boyutlar.radius20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Boyutlar.width10),
                                        Expanded(
                                            child: Container(
                                          height: Boyutlar.height20 * 5,
                                          //başlık ve fiyat ,arttırma azltma kısmı
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BuyukBaslik(text: sepetKontrolu.getItems[index].name!, color: Colors.black54),
                                              KucukBaslik(text: 'eqqweqwe'),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BuyukBaslik(text: sepetKontrolu.getItems[index].price.toString(), color: Colors.redAccent),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: Boyutlar.height10,
                                                      bottom: Boyutlar.height10,
                                                      left: Boyutlar.width10,
                                                      right: Boyutlar.width10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Boyutlar.radius20),
                                                      color: Colors.white,
                                                    ),
                                                    //artırma ve azaltma kısmı
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            sepetKontrolu.addItem(_cartList[index].product!, -1);
                                                            print('AZALTILDI');
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: AppColors.signColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: Boyutlar.width10 / 2),
                                                        BuyukBaslik(
                                                          text: _cartList[index].quantity.toString(),
                                                        ), //populerUrun.inCartItems.toString()),
                                                        SizedBox(width: Boyutlar.width10 / 2),
                                                        GestureDetector(
                                                          onTap: () {
                                                            sepetKontrolu.addItem(_cartList[index].product!, 1);
                                                            print('ARTTIRILDI');
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: AppColors.signColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : VeriSayfasiYok(text: 'Sepetin boş');
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<OrderController>(
          builder: (orderController) {
            _noteController.text = orderController.footNote;
            return GetBuilder<SepetKontrolu>(
              builder: (sepetKontrolu) {
                return Container(
                  //satın alam kısmın boyutlandırma
                  height: Boyutlar.bottomHeightBar + 65,
                  padding: EdgeInsets.only(
                    top: Boyutlar.height10,
                    bottom: Boyutlar.height10,
                    right: Boyutlar.width20,
                    left: Boyutlar.width20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Boyutlar.radius20 * 2),
                      topRight: Radius.circular(Boyutlar.radius20 * 2),
                    ),
                  ),
                  child: sepetKontrolu.getItems.length > 0
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.9,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(Boyutlar.radius20),
                                                topRight: Radius.circular(Boyutlar.radius20),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 520,
                                                  padding: EdgeInsets.only(
                                                    left: Boyutlar.width20,
                                                    right: Boyutlar.width20,
                                                    top: Boyutlar.height20,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const PaymentOptionButton(
                                                        icon: Icons.money,
                                                        title: 'cash on dasas',
                                                        subTitle: 'sadsdadasaddasdsa',
                                                        index: 0,
                                                      ),
                                                      SizedBox(height: Boyutlar.height10),
                                                      const PaymentOptionButton(
                                                        icon: Icons.payment_outlined,
                                                        title: 'digital payment',
                                                        subTitle: 'sadsdadasaddasdsa',
                                                        index: 1,
                                                      ),
                                                      SizedBox(height: Boyutlar.height30),
                                                      Text('Delivery options', style: robotoMedium),
                                                      SizedBox(height: Boyutlar.height10 / 2),
                                                      DeliveryOptions(
                                                        value: 'delivery',
                                                        title: 'home delivery',
                                                        amount: double.parse(Get.find<SepetKontrolu>().totalAmount.toString()),
                                                        isFree: false,
                                                      ),
                                                      SizedBox(height: Boyutlar.height10 / 2),
                                                      const DeliveryOptions(
                                                        value: 'take away',
                                                        title: 'take away',
                                                        amount: 10.0,
                                                        isFree: true,
                                                      ),
                                                      SizedBox(height: Boyutlar.height20),
                                                      Text('Additional notes', style: robotoMedium),
                                                      UygulamaMetinAlani(
                                                        textController: _noteController,
                                                        hintText: '',
                                                        icon: Icons.note,
                                                        maxLines: true,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).whenComplete(() => orderController.setFoodNote(_noteController.text.trim())),
                              child: const SizedBox(
                                width: double.maxFinite,
                                child: CommonTextButton(text: 'PAYMENT OPTİONS'),
                              ),
                            ),
                            SizedBox(height: Boyutlar.height10),
                            Row(
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
                                      SizedBox(width: Boyutlar.width10 / 2),
                                      BuyukBaslik(text: '\$ ' + sepetKontrolu.totalAmount.toString()),
                                      SizedBox(width: Boyutlar.width10 / 2),
                                    ],
                                  ),
                                ),
                                //sepete ekleme kısmı
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>().userLoggedIn()) {
                                      if (Get.find<LocationController>().addressList.isEmpty) {
                                        Get.toNamed(RouteHelper.getAddressPage());
                                      } else {
                                        var location = Get.find<LocationController>().getUserAddress();
                                        var cart = Get.find<SepetKontrolu>().getItems;
                                        var user = Get.find<UserController>().userModel;
                                        PlaceOrderBody placeOrder = PlaceOrderBody(
                                          cart: cart,
                                          orderAmount: 100.0,
                                          orderNote: orderController.footNote,
                                          address: location.address,
                                          latitude: location.latitude,
                                          longitude: location.longitude,
                                          contactPersonNumber: user.phone,
                                          contactPersonName: user.name,
                                          scheduleAt: '',
                                          distance: 10.0,
                                          paymentMethod: orderController.paymentIndex == 0 ? 'cash_on_delivery' : 'digital_payment',
                                          orderType: orderController.orderType,
                                        );
                                        Get.find<OrderController>().placeOrder(placeOrder, _callback);
                                      }
                                    } else {
                                      Get.toNamed(RouteHelper.getSignInPage());
                                    }
                                  },
                                  child: CommonTextButton(text: 'ÖDEME'),
                                )
                              ],
                            ),
                          ],
                        )
                      : Container(),
                );
              },
            );
          },
        ));
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<SepetKontrolu>().clear();
      Get.find<SepetKontrolu>().removeCardSharedPreference();
      Get.find<SepetKontrolu>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, 'success'));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
