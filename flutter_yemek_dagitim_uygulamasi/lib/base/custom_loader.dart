import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Boyutlar.height20 * 5,
        width: Boyutlar.font20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Boyutlar.height20 * 5 / 2),
          color: AppColors.mainColor,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
