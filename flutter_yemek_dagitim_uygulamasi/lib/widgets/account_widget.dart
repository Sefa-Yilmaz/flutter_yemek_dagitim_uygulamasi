import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_icon.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';

class HesapWidget extends StatelessWidget {
  AppIcon appIcon;
  BuyukBaslik buyukBaslik;
  HesapWidget({super.key, required this.appIcon, required this.buyukBaslik});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Boyutlar.width20,
          top: Boyutlar.width10,
          bottom: Boyutlar.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Boyutlar.width20),
          buyukBaslik,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}
