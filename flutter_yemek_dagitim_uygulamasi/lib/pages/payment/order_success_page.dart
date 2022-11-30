import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/costom_button.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({super.key, required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(
        Duration(seconds: 1),
        () {
          // Get.dialog(PaymentFailedDialog(orderID:orderID),barrierDismissible: false);
        },
      );
    }
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: Boyutlar.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == 1 ? Icons.check_circle_outline : Icons.warning_amber_outlined,
              size: 100,
              color: AppColors.mainColor,
            ),
            SizedBox(height: Boyutlar.height45),
            Text(
              status == 1 ? 'You placed the order successfully' : 'You order faild',
              style: TextStyle(fontSize: Boyutlar.font20),
            ),
            SizedBox(height: Boyutlar.height20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Boyutlar.font20, vertical: Boyutlar.height10),
              child: Text(
                status == 1 ? 'Successful order' : 'Failed order',
                style: TextStyle(fontSize: Boyutlar.font20, color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Boyutlar.height10),
            Padding(
              padding: EdgeInsets.all(Boyutlar.height10),
              child: CustomButton(
                buttonText: 'Black to Home',
                onPressed: () => Get.offAllNamed(
                  RouteHelper.getInitial(),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
