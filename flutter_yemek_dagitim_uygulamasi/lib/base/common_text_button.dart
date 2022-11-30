import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Boyutlar.height20, bottom: Boyutlar.height20, left: Boyutlar.width20, right: Boyutlar.width20),
      child: Center(
        child: BuyukBaslik(
          text: text,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10,
            color: AppColors.mainColor.withOpacity(0.3),
          )
        ],
        borderRadius: BorderRadius.circular(Boyutlar.radius20),
        color: AppColors.mainColor,
      ),
    );
  }
}
