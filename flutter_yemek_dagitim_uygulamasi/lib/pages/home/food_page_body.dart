import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/popular_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/recommended_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/products_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/app_constants.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_column.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/icon_ve_text_widgets.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/kucuk_baslik.dart';
import 'package:get/get.dart';

class YemekSayfasiBody extends StatefulWidget {
  const YemekSayfasiBody({super.key});

  @override
  State<YemekSayfasiBody> createState() => _YemekSayfasiBodyState();
}

class _YemekSayfasiBodyState extends State<YemekSayfasiBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  final double _height = Boyutlar.pageViewContainer;
  //animasyon kodların kotrolu
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  //animasyon kodların kotrolu
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  //animasyon kodların kotrolu
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //yemek gosteren secim ekranı
    return Column(
      children: [
        //resimlerin sırası ile cekildigi yer
        GetBuilder<PopulerUrunDenetleyicisi>(builder: (PopulerUrun) {
          return PopulerUrun.isLoaded
              ? SizedBox(
                  height: Boyutlar.pageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: PopulerUrun.populerUrunList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(
                          position, PopulerUrun.populerUrunList[position]);
                    },
                  ),
                )
              //resimlerin gelirken donen daire kısmı
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //anasayfadaki yemeklerin secim ekranın sag sola kaydırma animasyonu
        GetBuilder<PopulerUrunDenetleyicisi>(builder: (PopulerUrun) {
          return DotsIndicator(
            dotsCount: PopulerUrun.populerUrunList.isEmpty
                ? 1
                : PopulerUrun.populerUrunList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9),
              activeSize: const Size(18, 9),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
        SizedBox(height: Boyutlar.height30),
        //populer
        //recommended kısmın yazısı
        Container(
          margin: EdgeInsets.only(left: Boyutlar.width30),
          child: Row(
            children: [
              BuyukBaslik(text: 'Recommended'),
              SizedBox(width: Boyutlar.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BuyukBaslik(text: '.', color: Colors.black26),
              ),
              SizedBox(width: Boyutlar.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: KucukBaslik(text: 'Yemek eşleştirme'),
              ),
            ],
          ),
        ),
//yemek listesi ve resimler RecommendedFood
        GetBuilder<OnerilenUrunDenetleyicisi>(builder: (OnerilenUrun) {
          return OnerilenUrun.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: OnerilenUrun.onerilenUrunList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, 'home'));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Boyutlar.width20,
                            right: Boyutlar.width20,
                            bottom: Boyutlar.height10),
                        child: Row(
                          children: [
                            //anasayfadaki listelenmis yemeklerin resim kutusu
                            Container(
                              width: Boyutlar.listViewImgSize,
                              height: Boyutlar.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Boyutlar.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL +
                                      OnerilenUrun
                                          .onerilenUrunList[index].img!),
                                ),
                              ),
                            ),
                            //anasayfadaki listelenmis yemeklerin text kutusu
                            Expanded(
                              child: Container(
                                height: Boyutlar.listViewTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(Boyutlar.radius20),
                                    bottomLeft:
                                        Radius.circular(Boyutlar.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Boyutlar.width10,
                                      right: Boyutlar.width10),
                                  //anasayfadaki listelenmis yemeklerin baslık yol dk gibi bilgilerin yazıldıgı yer
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BuyukBaslik(
                                          text: OnerilenUrun
                                              .onerilenUrunList[index].name!),
                                      SizedBox(height: Boyutlar.height10),
                                      KucukBaslik(text: 'assda'),
                                      SizedBox(height: Boyutlar.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              //yukleme simgesi
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel populerUrun) {
    //animasyon kodları
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          //yemek reseimlerin getirildigi yer
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              height: Boyutlar.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Boyutlar.width10, right: Boyutlar.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Boyutlar.radius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                //interneten resimleri getiriyor
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      populerUrun.img!),
                ),
              ),
            ),
          ),
          //yemek resmin altındakı kutucuk
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Boyutlar.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Boyutlar.width30,
                  right: Boyutlar.width30,
                  bottom: Boyutlar.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Boyutlar.radius30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  )
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Boyutlar.height15,
                  left: Boyutlar.height15,
                  right: Boyutlar.height15,
                ),
                //anasayfadaki yemek resmin altındaki kutucun icindekşi yazılar
                child: AppColumn(text: populerUrun.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
