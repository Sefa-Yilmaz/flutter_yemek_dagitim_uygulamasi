import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/no_data_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/cart_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_icon.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/kucuk_baslik.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//satın alam gecmişi
class SepetGecmisi extends StatelessWidget {
  const SepetGecmisi({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<SepetKontrolu>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
//zaman kısmı
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm')
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd/MM/yyyy HH:mm a');
        outputDate = outputFormat.format(inputDate);
      }
      return BuyukBaslik(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Boyutlar.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Boyutlar.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BuyukBaslik(text: 'Sepet geçmişi', color: Colors.white),
                const AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    IconColor: AppColors.mainColor)
              ],
            ),
          ),
          GetBuilder<SepetKontrolu>(builder: (_sepetKontrolu) {
            return _sepetKontrolu.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Boyutlar.height20,
                        left: Boyutlar.width20,
                        right: Boyutlar.width20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Boyutlar.height45 * 4,
                                margin:
                                    EdgeInsets.only(bottom: Boyutlar.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //zaman kısmı
                                    timeWidget(listCounter),
                                    SizedBox(height: Boyutlar.height10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                            itemsPerOrder[i],
                                            (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Boyutlar.height20 * 5,
                                                      width:
                                                          Boyutlar.height20 * 5,
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              Boyutlar.width10 /
                                                                  2),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Boyutlar
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOAD_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: Boyutlar.height20 * 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              KucukBaslik(
                                                  text: 'Total',
                                                  color: AppColors.titleColor),
                                              BuyukBaslik(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      ' Items',
                                                  color: AppColors.titleColor),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, SepetModel>
                                                      moreOrder = {};
                                                  for (var j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () =>
                                                            SepetModel.fromJson(
                                                          jsonDecode(jsonEncode(
                                                              getCartHistoryList[
                                                                  j])),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  Get.find<SepetKontrolu>()
                                                      .setItems = moreOrder;
                                                  Get.find<SepetKontrolu>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCardPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Boyutlar.width10,
                                                      vertical:
                                                          Boyutlar.height10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Boyutlar.radius15 /
                                                                3),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                  child: KucukBaslik(
                                                      text: 'one more',
                                                      color:
                                                          AppColors.mainColor),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: VeriSayfasiYok(
                        text: 'Şimdiye kadar hiçbir şey satın almadın !',
                        imgPath: 'assets/image/empty_box.png',
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
