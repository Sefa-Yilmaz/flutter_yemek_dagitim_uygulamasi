import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/custom_loader.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/show_custom_snackbar.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/auth_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/auth/sign_up_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_text_field.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:get/get.dart';

class GirisSayfasi extends StatelessWidget {
  const GirisSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    var emailKontrol = TextEditingController();
    var passwordKontrol = TextEditingController();
    

    void _login(AuthController authController) {
      String email = emailKontrol.text.trim();
      String password = passwordKontrol.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar('Email adresinizi giriniz', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Gecerli bir email giriniz',
            title: 'Gecerli email adresi');
      } else if (password.isEmpty) {
        showCustomSnackBar('Şifrenizi  giriniz', title: 'Şifre');
      } else if (password.length < 6) {
        showCustomSnackBar('Şifrreniz 6 karakterden oluşmalıdır',
            title: 'şifre');
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
           // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getCardPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: Boyutlar.screenHeight * 0.05),
                    //app logo
                    SizedBox(
                      height: Boyutlar.screenHeight * 0.25,
                      child: const Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/image/logo part 1.png'),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: Boyutlar.width20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: TextStyle(
                              fontSize:
                                  Boyutlar.font20 * 3 + Boyutlar.font20 / 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Hesabınıza giriş yapın!',
                            style: TextStyle(
                              fontSize: Boyutlar.font20,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Boyutlar.screenHeight * 0.05),
                    Column(
                      children: [
                        //email kısmı
                        UygulamaMetinAlani(
                            textController: emailKontrol,
                            hintText: 'Email',
                            icon: Icons.email),
                        SizedBox(height: Boyutlar.height20),
                        //şifre kısmı
                        UygulamaMetinAlani(
                          textController: passwordKontrol,
                          hintText: 'Password',
                          icon: Icons.password_sharp,
                          isObscure: true,
                        ),
                        SizedBox(height: Boyutlar.height20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: Boyutlar.height30),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Hesabınıza giriş yapın!',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: Boyutlar.font20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Boyutlar.screenHeight * 0.05),
                        //giriş kısmı
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            width: Boyutlar.screenWidth / 2,
                            height: Boyutlar.screenHeight / 13,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Boyutlar.radius30),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: BuyukBaslik(
                                text: 'Giriş Yap',
                                size: Boyutlar.font20 + Boyutlar.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Boyutlar.screenHeight * 0.05),
                        RichText(
                          text: TextSpan(
                              text: 'Hesabınız yokmu? ',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: Boyutlar.font26,
                              ),
                              children: [
                                //üye ol kısmı giden yer
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(
                                        () => const KayitSayfasi(),
                                        transition: Transition.fade),
                                  text: 'Üye Ol',
                                  style: TextStyle(
                                    color: AppColors.mainBlackColor,
                                    fontSize: Boyutlar.font26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: Boyutlar.height10),
                      ],
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
