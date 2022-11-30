import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/kucuk_baslik.dart';

class IconVeTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;
  const IconVeTextWidget(
      {required this.icon,
      required this.text,
      required this.iconColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    //icon ve text kısmı
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Boyutlar.iconSize24,
        ),
        const SizedBox(width: 5),
        KucukBaslik(text: text),
      ],
    );
  }
}
