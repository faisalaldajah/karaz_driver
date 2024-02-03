import 'package:get/get.dart';
import 'package:karaz_driver/Utilities/routes/routes_string.dart';
import 'package:karaz_driver/screens/DriverRegistration/bindings/delivery_registration_binding.dart';
import 'package:karaz_driver/screens/DriverRegistration/views/delivery_registration_view.dart';
import 'package:karaz_driver/screens/LogIn/login_binding.dart';
import 'package:karaz_driver/screens/LogIn/loginpage.dart';
import 'package:karaz_driver/screens/mainPage/mainPageBinding.dart';
import 'package:karaz_driver/screens/mainPage/mainpage.dart';
import 'package:karaz_driver/screens/onbording/onboarding_view.dart';
import 'package:karaz_driver/screens/onbording/onbording_binding.dart';
import 'package:karaz_driver/screens/splash/splash_binding.dart';
import 'package:karaz_driver/screens/splash/splash_view.dart';
import 'package:karaz_driver/screens/welcome/welcome.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: '/',
    page: () => const SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: RoutesString.onboarding,
    page: () => OnBoardingScreen(),
    binding: OnboardingBinding(),
  ),
  GetPage(
    name: RoutesString.welcome,
    page: () => const WelcomeScreen(),
  ),
  GetPage(
    name: RoutesString.login,
    page: () => const LoginPage(),
    binding: LogInBinding(),
  ),
  GetPage(
    name: RoutesString.signUp,
    page: () => const RegistrationView(),
    binding: RegistrationBinding(),
  ),
  GetPage(
    name: RoutesString.home,
    page: () => const MainPage(),
    binding: MainPageBinding(),
  )
];
