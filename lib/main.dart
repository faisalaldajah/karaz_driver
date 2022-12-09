import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:karaz_driver/Services/settings_service.dart';
import 'package:karaz_driver/Services/translation_service.dart';
import 'package:karaz_driver/Utilities/Methods/tools.dart';
import 'package:karaz_driver/Utilities/RoutesManagement/pages.dart';
import 'package:karaz_driver/dataprovider.dart';
import 'package:karaz_driver/globalvariabels.dart';
import 'package:karaz_driver/helpers/pushnotificationservice.dart';
import 'package:karaz_driver/screens/LogIn/login_binding.dart';
import 'package:karaz_driver/screens/LogIn/loginpage.dart';
import 'package:karaz_driver/screens/UnRegistration.dart';
import 'package:karaz_driver/screens/mainPage/mainpage.dart';
import 'package:karaz_driver/screens/splash/splash_binding.dart';
import 'package:karaz_driver/screens/splash/splash_view.dart';
import 'package:vibration/vibration.dart';

final FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> backgroundHandler(RemoteMessage message) async {
  print('object');
  String rideID = message.data['ride_id'];
  print(rideID);
  PushNotificationService().fetchRideInfo(rideID);
}

Future<void> notificationConfiguration() async {
  await FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //inside application
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Vibration.vibrate(duration: 500);
      FlutterRingtonePlayer.play(
          android: AndroidSounds.notification, // will be the sound on Android
          ios: IosSounds.bell // will be the sound on iOS
          );
      CommonTools().notifcationBarInApp(message);
      log(message.toMap().toString());
    });
    //open notification from notification up drawer
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String rideID = message.data['ride_id'];
      PushNotificationService().fetchRideInfo(rideID);
    });
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await notificationConfiguration();
  await GetStorage.init();

  await Get.putAsync(() => SettingsService().init());

  LogInBinding().dependencies();

  SplashBinding().dependencies();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        margin: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('images/undraw_bug_fixing_oc-7-a.svg'),
            const SizedBox(height: 30),
            Text(details.exception.toString()),
            const SizedBox(height: 30),
            Text(details.stackFilter.toString())
          ],
        ),
      ),
    );
  };

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  currentFirebaseUser = FirebaseAuth.instance.currentUser;

  final fcmToken = await FirebaseMessaging.instance.getToken();

  print(fcmToken);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        translations: TranslationService(),
        locale: SettingsService().getLocale(),
        fallbackLocale: TranslationService.fallbackLocale,
        theme: Get.find<SettingsService>().getLightTheme(),
        getPages: AppPages.routes,
        home: currentFirebaseUser == null
            ? const LoginPage()
            : const SplashView(),
        routes: {
          MainPage.id: (context) => const MainPage(),
          LoginPage.id: (context) => const LoginPage(),
          UnRegistration.id: (context) => const UnRegistration(),
        },
      ),
    );
  }
}
