import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/kucuk_baslik.dart';

//detaylı yazılar
class DetayYazi extends StatefulWidget {
  final String text;
  const DetayYazi({super.key, required this.text});

  @override
  State<DetayYazi> createState() => _DetayYaziState();
}

class _DetayYaziState extends State<DetayYazi> {
  late String kisaYazi;
  late String uzunYazi;
  bool hiddenText = true;

  double textHeight = Boyutlar.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      kisaYazi = widget.text.substring(0, textHeight.toInt());
      uzunYazi =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      kisaYazi = widget.text;
      uzunYazi = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: uzunYazi.isEmpty
          ? KucukBaslik(
              color: AppColors.paraColor, size: Boyutlar.font16, text: kisaYazi)
          : Column(
              children: [
                KucukBaslik(
                    height: 1.8,
                    color: AppColors.paraColor,
                    size: Boyutlar.font16,
                    text: hiddenText
                        ? (kisaYazi + "...")
                        : (kisaYazi + uzunYazi)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      KucukBaslik(
                        text: 'Daha fazla göster',
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
