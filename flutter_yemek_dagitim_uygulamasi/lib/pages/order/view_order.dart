import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/custom_loader.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/order_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/order_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/styles.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(
        builder: (orderController) {
          if (orderController.isLoading == false) {
            late List<OrderModel> orderList;
            if (orderController.currentOrderList.isNotEmpty) {
              orderList = orderController.currentOrderList.reversed.toList();
              orderController.historyOrderList.reversed.toList();
            }
            return SizedBox(
              width: Boyutlar.screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Boyutlar.width10 / 2, vertical: Boyutlar.height10 / 2),
                child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => null,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('order ID', style: robotoRegular.copyWith(fontSize: Boyutlar.font12)),
                                    SizedBox(width: Boyutlar.width10 / 2),
                                    Text('#${orderList[index].id.toString()}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(Boyutlar.radius20 / 4),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: Boyutlar.width10, vertical: Boyutlar.width10 / 2),
                                      child: Text(
                                        '${orderList[index].orderStatus}',
                                        style: robotoMedium.copyWith(fontSize: Boyutlar.font12, color: Theme.of(context).cardColor),
                                      ),
                                    ),
                                    SizedBox(height: Boyutlar.height10 / 2),
                                    InkWell(
                                      onTap: () => null,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: Boyutlar.width10, vertical: Boyutlar.width10 / 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Boyutlar.radius20 / 4),
                                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/tracking.png',
                                              width: 15,
                                              height: 15,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            SizedBox(width: Boyutlar.width10 / 2),
                                            Text(
                                              'track order',
                                              style: robotoMedium.copyWith(fontSize: Boyutlar.font12, color: Theme.of(context).primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Boyutlar.height10),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return CustomLoader();
          }
        },
      ),
    );
  }
}
