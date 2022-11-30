// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';

class UygulamaMetinAlani extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  UygulamaMetinAlani({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.maxLines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Boyutlar.height20, right: Boyutlar.height20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Boyutlar.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(1, 11),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
      child: TextField(
        maxLines: maxLines ? 3 : 1,
        obscureText: isObscure ? true : false,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Boyutlar.radius15),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Boyutlar.radius15),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Boyutlar.radius15),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
