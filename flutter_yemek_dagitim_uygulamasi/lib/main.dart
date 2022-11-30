import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/cart_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/popular_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/recommended_product_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/helper/notification_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/address/add_address_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/auth/sign_in_page.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/dependencies.dart' as dep;

/* Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print('onBackGround:${message.notification?.title}/${message.notification?.body}/'
      '${message.notification?.titleLocKey}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  runApp(const MyApp());
} */

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<SepetKontrolu>().getCartData();
    return GetBuilder<PopulerUrunDenetleyicisi>(builder: (_) {
      return GetBuilder<OnerilenUrunDenetleyicisi>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: 'Lato',
          ),
          //home: GirisSayfasi(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
