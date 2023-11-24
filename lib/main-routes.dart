import 'package:rzume/screens/auth/auth-routes.dart';
import 'package:rzume/screens/start/splash.dart';
import 'package:rzume/screens/start/startscreen.dart';
import 'package:rzume/screens/utility/otp-verificationscreen.dart';
import 'package:rzume/widgets/start-control.dart';

final routes = {
  '/': (context) => const StartControl(),
  '/splash': (context) => const SplashScreen(),
  '/start': (context) => const StartScreen(),
  ...authRoutes,
  '/otp-verification': (context) => const OtpVerificationScreen(),
};
