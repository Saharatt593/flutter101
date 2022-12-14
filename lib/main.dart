import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter101/core/config/fcm/fcm_notification.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter101/core/di/di.dart';
import 'package:flutter101/core/di/local_controller.dart';
import 'package:flutter101/core/flavor/flavor_config.dart';
import 'package:flutter101/core/local/localizations_delegate.dart';
import 'package:flutter101/core/themes/theme.dart';
import 'package:flutter101/src/pages/main/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

void mainApp() async {
  initGetX();

  await Firebase.initializeApp();

  await PushNotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final title = "Flutter Demo Home Page";

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // unknownRoute:  GetPage(
      //   name: "rootPage",
      //   page: () => MainPage(),
      // ),
      // routes: Routes.getRoute(),
      getPages: Routes.getPageRoute(),
      initialRoute: Routes.rootPage,
      // locale: const Locale('en', 'US'),
      // translations: LocaleString(),
      // fallbackLocale: const Locale('th', 'TH'),
      locale: Get.locale,
      supportedLocales: LocalController.supportedLocales,
      localizationsDelegates:  [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
        },
        'th_TH': {
          'hello': '??????????????????',
        }
      };
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flavor: ${FlavorConfig.instance.name}"),
            const Divider(
              height: 8,
            ),
            Image.asset(
              "assets/show_1.png",
              width: 100,
              height: 100,
              color: Colors.red,
              colorBlendMode: BlendMode.hue,
              repeat: ImageRepeat.noRepeat,
            ),
            Image.network(
              "https://i.pinimg.com/originals/0e/3a/14/0e3a14f24ec57009648910c958f318af.jpg",
              width: 100,
              height: 100,
              headers: const {"Authorization": "Bearer TOKEN"},
            ),
            const LinearProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
