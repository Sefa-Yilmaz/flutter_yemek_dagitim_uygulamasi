import 'package:flutter/material.dart';


// ignore: must_be_immutable
class KucukBaslik extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  KucukBaslik({
    super.key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    //kucuk baslık
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size, //== 0 ? Boyutlar.font12 : size,
        height: height,
      ),
    );
  }
}
