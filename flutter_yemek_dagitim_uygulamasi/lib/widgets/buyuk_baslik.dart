import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';


// ignore: must_be_immutable
class BuyukBaslik extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BuyukBaslik(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    //buyuk baslık kısmı
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Boyutlar.font20 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
