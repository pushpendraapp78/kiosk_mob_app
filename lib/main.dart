import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/services/route_generator.dart';

import 'Constant/color_const.dart';
import 'Constant/common_constant.dart';
import 'Constant/enums.dart';
import 'Utils/tools.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  CommonConstant.initializeApp(Mode.DEV);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IpBot',
      navigatorKey: Tools.navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      getPages: appRoutes(),
      initialRoute: '/splash',
      theme: ThemeData(
          primaryColor: primaryColorCode,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          fontFamily: 'nunito',
          brightness: Brightness.light),
      locale: Get.locale,
      fallbackLocale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
