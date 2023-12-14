import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:rzume/config/environment.dart';
import 'package:rzume/main_routes.dart';
import 'package:rzume/screens/auth/auth-routes.dart';
import 'package:rzume/screens/auth/signup/signupscreen.dart';

import 'package:rzume/screens/start/splash.dart';
import 'package:rzume/screens/start/startscreen.dart';
import 'package:rzume/screens/utility/otp_verificationscreen.dart';
import 'package:rzume/ui/info_modal.dart';
import 'package:rzume/widgets/counter_notifier.dart';
import 'package:rzume/widgets/info_overlay_caller.dart';
import 'package:rzume/widgets/misc_notifier.dart';
import 'package:rzume/widgets/start_control.dart';
import 'package:rzume/widgets/theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MiscNotifer()),
        ChangeNotifierProvider(create: (context) => CounterNotifier())
      ],
      child: MaterialApp(
          theme: lightThemeData,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: <Widget>[
                child!,
                const Infomodal(),
              ],
            );
          },
          darkTheme: darkThemeData,
          routes: routes),
    );
  }
}
