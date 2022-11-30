import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/order_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/styles.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;
  const PaymentOptionButton({super.key, required this.icon, required this.title, required this.subTitle, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        bool _selected = orderController.paymentIndex == index;
        return InkWell(
          onTap: () => orderController.setPaymentIndex(index),
          child: Container(
            padding: EdgeInsets.only(bottom: Boyutlar.height10 / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Boyutlar.radius20 / 4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ],
            ),
            child: ListTile(
                leading: Icon(
                  icon,
                  size: 40,
                  color: _selected ? AppColors.mainBlackColor : Theme.of(context).disabledColor,
                ),
                title: Text(
                  title,
                  style: robotoMedium.copyWith(fontSize: Boyutlar.font20),
                ),
                subtitle: Text(
                  subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: robotoRegular.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Boyutlar.font16,
                  ),
                ),
                trailing: _selected
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      )
                    : null),
          ),
        );
      },
    );
  }
}
