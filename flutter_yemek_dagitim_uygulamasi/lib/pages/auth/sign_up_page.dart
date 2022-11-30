import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/custom_loader.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/show_custom_snackbar.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/auth_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/signup_body_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/auth/sign_in_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_text_field.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:get/get.dart';

class KayitSayfasi extends StatelessWidget {
  const KayitSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    var emailKontrol = TextEditingController();
    var passwordKontrol = TextEditingController();
    var nameKontrol = TextEditingController();
    var phoneKontrol = TextEditingController();
    var singUpImages = ['t.png', 'f.png', 'g.png'];

    //üye ol kısmı kotrolu
    void _registration(AuthController authController) {
      String name = nameKontrol.text.trim();
      String phone = phoneKontrol.text.trim();
      String email = emailKontrol.text.trim();
      String password = passwordKontrol.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar('Adınızı giriniz', title: 'Adınız');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Telefon numaranızı giriniz',
            title: 'Telefon numarası');
      } else if (email.isEmpty) {
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
        SingUpBody singUpBody = SingUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );

        authController.registration(singUpBody).then((status) {
          if (status.isSuccess) {
            print('dassdadas');
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: Boyutlar.screenHeight * 0.05),
                    //app logo
                    Container(
                      height: Boyutlar.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/image/logo part 1.png'),
                        ),
                      ),
                    ),

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
                        //isim kısmı
                        UygulamaMetinAlani(
                            textController: nameKontrol,
                            hintText: 'Name',
                            icon: Icons.person),
                        SizedBox(height: Boyutlar.height20),
                        //telefon kısmı
                        UygulamaMetinAlani(
                            textController: phoneKontrol,
                            hintText: 'Phone',
                            icon: Icons.phone),
                        SizedBox(height: Boyutlar.height20 * 2),
                        //üye ol butonu
                        GestureDetector(
                          onTap: () {
                            _registration(_authController);
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
                                text: 'Üye Ol',
                                size: Boyutlar.font20 + Boyutlar.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Boyutlar.height15),
                        //var olan hesaba giriş kısmı
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Get.to(() => const GirisSayfasi()),
                            text: 'Zaten bir hesabınız varmı?',
                            style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Boyutlar.font20,
                            ),
                          ),
                        ),
                        SizedBox(height: Boyutlar.height20),
                        RichText(
                          text: TextSpan(
                            text:
                                'Aşağıdaki yöntemlerden birini kullanarak kaydolun?',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Boyutlar.font16,
                            ),
                          ),
                        ),
                        SizedBox(height: Boyutlar.height10),
                        //sosyal medya ile giriş kısmı
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: Boyutlar.radius30,
                                      backgroundImage: AssetImage(
                                          'assets/image/' +
                                              singUpImages[index]),
                                    ),
                                  )),
                        )
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
