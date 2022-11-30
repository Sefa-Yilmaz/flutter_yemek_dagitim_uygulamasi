import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/icon_ve_text_widgets.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/kucuk_baslik.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    //başlık ve zaman mesafe gibi yazıların kutusu
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuyukBaslik(
          text: text,
          size: Boyutlar.font26,
        ),
        SizedBox(height: Boyutlar.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) {
                  return const Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: 15,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            KucukBaslik(text: '4.5'),
            const SizedBox(width: 10),
            KucukBaslik(text: '1287'),
            const SizedBox(width: 10),
            KucukBaslik(text: 'Yorumlar'),
          ],
        ),
        SizedBox(height: Boyutlar.height20),
        //zaman ve mesafa
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconVeTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            IconVeTextWidget(
              icon: Icons.location_on,
              text: '1.7km',
              iconColor: AppColors.mainColor,
            ),
            IconVeTextWidget(
              icon: Icons.access_time_rounded,
              text: '32DK',
              iconColor: AppColors.iconColor2,
            )
          ],
        )
      ],
    );
  }
}
